Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4041936E0
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 04:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgCZDZv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 23:25:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:55854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728096AbgCZDZh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 25 Mar 2020 23:25:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D6ADAAD4F;
        Thu, 26 Mar 2020 03:25:34 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker\@Netapp.com" <Anna.Schumaker@Netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Date:   Thu, 26 Mar 2020 14:25:21 +1100
Subject: [PATCH/RFC] MM: fix writeback for NFS
cc:     linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <87tv2b7q72.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Page account happens a little differently for NFS, and writeback is
aware of this, but handles it wrongly.
With NFS, pages go throught three states which are accounted separately:
 NR_FILE_DIRTY - page is dirty and unwritten
 NR_WRITEBACK  - page is being written back
 NR_UNSTABLE_NFS - page has been written, but might need to be written
		again if server restarts.  Once an NFS COMMIT
		completes, page becomes freeable.

writeback combines both the NF_FILE_DIRTY counters and NF_UNSTABLE_NFS
together, which doesn't make a lot of sense.  NR_UNSTABLE_NFS is more
like NR_WRITEBACK in that there is nothing that can be done for these
pages except wait.

Current behaviour is that when there are a lot of NR_UNSTABLE_NFS pages,
balance_dirty_pages() repeatedly schedules the writeback thread, even
when the number of dirty pages is below the threshold.  This result is
each ->write_pages() call into NFS only finding relatively few DIRTY
pages, so it creates requests that are well below the maximum size.
Depending on performance of characteristics of the server, this can
substantially reduce throughput.

There are two places where balance_dirty_pages() schedules the writeback
thread, and each of them schedule writeback too often.

1/ When balance_dirty_pages() determines that it must wait for the
   number of dirty pages to shrink, it unconditionally schedules
   writeback.
   This is probably not ideal for any filesystem but I measured it to be
   harmful for NFS.  This writeback should only be scheduled if the
   number of dirty pages is above the threshold.  While it is below,
   waiting for the pending writes to complete (and be committed) is a more
   appropriate behaviour.

2/ When balance_dirty_pages() finishes, it again shedules writeback
   if nr_reclaimable is above the background threshold.  This is
   conceptually correct, but wrong because nr_reclaimable is wrong.
   The impliciation of this usage is that nr_reclaimable is the number
   of pages that can be reclaimed if writeback is triggered.  In fact it
   is NR_FILE_DIRTY plus NR_UNSTABLE_NFS, which is not a meaningful
   number.

So this patch removes NR_UNSTABLE_NFS from nr_reclaimable, and only
schedules writeback when the new nr_reclaimable is greater than
=2D>thresh or ->bg_thresh, depending on context.

The effect of this can be measured by looking at the count of
nfs_writepages calls while performing a large streaming write (larger
than dirty_threshold)

e.g.
  mount -t nfs server:/path /mnt
  dd if=3D/dev/zero of=3D/mnt/zeros bs=3D1M count=3D1000
  awk '/events:/ {print $13}' /proc/self/mountstats

Each writepages call should normally submit writes for 4M (1024 pages)
or more (MIN_WRITEBACK_PAGES) (unless memory size is tiny).
With the patch I measure typically 200-300 writepages calls with the
above, which suggests an average of about 850 pages being made available to
each writepages call.  This is less than MIN_WRITEBACK_PAGES, but enough
to assemble large 1MB WRITE requests fairly often.

Without the patch, numbers range from about 2000 to over 10000, meaning
an average of maybe 100 pages per call, which means we rarely get large
1M requests, and often get small requests

Note that there are other places where NR_FILE_DIRTY and NR_UNSTABLE_NFS
are combined (wb_over_bg_thresh() and get_nr_dirty_pages()).  I suspect
they are wrong too.  I also suspect that unstable-NFS pages should not be
included in the WB_RECLAIMABLE wb_stat, but I haven't explored that in
detail yet.

Note that the current behaviour of NFS w.r.t sending COMMIT requests is
that as soon as a batch of writes all complete, a COMMIT is scheduled.
Prior to commit 919e3bd9a875 ("NFS: Ensure we commit after writeback is
complete"), other mechanisms triggered the COMMIT.  It is possible that
the current writeback code made more sense before that commit.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 mm/page-writeback.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 2caf780a42e7..99419cba1e7a 100644
=2D-- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1593,10 +1593,11 @@ static void balance_dirty_pages(struct bdi_writebac=
k *wb,
 		 * written to the server's write cache, but has not yet
 		 * been flushed to permanent storage.
 		 */
=2D		nr_reclaimable =3D global_node_page_state(NR_FILE_DIRTY) +
=2D					global_node_page_state(NR_UNSTABLE_NFS);
+		nr_reclaimable =3D global_node_page_state(NR_FILE_DIRTY);
 		gdtc->avail =3D global_dirtyable_memory();
=2D		gdtc->dirty =3D nr_reclaimable + global_node_page_state(NR_WRITEBACK);
+		gdtc->dirty =3D nr_reclaimable +
+			global_node_page_state(NR_WRITEBACK) +
+			global_node_page_state(NR_UNSTABLE_NFS);
=20
 		domain_dirty_limits(gdtc);
=20
@@ -1664,7 +1665,8 @@ static void balance_dirty_pages(struct bdi_writeback =
*wb,
 			break;
 		}
=20
=2D		if (unlikely(!writeback_in_progress(wb)))
+		if (nr_reclaimable > gdtc->thresh &&
+		    unlikely(!writeback_in_progress(wb)))
 			wb_start_background_writeback(wb);
=20
 		mem_cgroup_flush_foreign(wb);
=2D-=20
2.25.2


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl58IKIACgkQOeye3VZi
gbm0kA//S4tZFypb4X9O3m1jpKH4hS21QOLhfE6Su7e7QnvQ/RhDjh+XfQMgQlzN
ih2rwz/J3tJN8HKvxK/8nK2ssqRXittASSn+0jZod4qLI47Or71MqZaK58on1xfr
sq9Hfw0AR80tsxwwvligo1gwg53oxjpJty1gA0yNP/dTaiYL7+q9+Fau//IdcZq0
DmVYIlglNucRW0mc8uOarT9WVo8g7v5LSRBOpIRyvc61/Mw8WP4tvlaKVUdSWijA
V8NGGFJw7hJgbRq1VUBhPM2euD6lDzzLrlDLAUPoUbajwaGPxkP8mA09vTzmrinL
HAFVIKBLVCCsfzZmYdXloyhrDRYFAFNujtsGdt/sqRocVDppCyWMZlfN+PdEomPQ
dOQsTqAdrSZJeHwdhcqYfh6z6n6VEmTkjIwQeY3jtLBHUWHjjCnS4Ja8NKdF40Ub
nNs3bLif3rV0pGjmJJ81O9oWglRRHoXTWt5PaU5m1kOEJjGuEthh/fjY1wZw9ejF
muqWZZDpmfGxeRYgqR3xe1koh+MSPZuRp/timuX5B1mG7gcN1BUTX0dkBBHJbBdz
oQHuuH6+F2zynjbCubaVigbC1cyiqdANrT9Itixi7VWoxqSzLds7KOBi8P/xSCzL
gVR+i40MT3D6NDMaYefGkXX1CVAw4jbkaVHaKraoOIx1qZJiDAg=
=A5hb
-----END PGP SIGNATURE-----
--=-=-=--
