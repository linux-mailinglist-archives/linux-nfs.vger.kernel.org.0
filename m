Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFFE2A73A7
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 01:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgKEANC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 19:13:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:41916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728323AbgKEANC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Nov 2020 19:13:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D667AD1A
        for <linux-nfs@vger.kernel.org>; Thu,  5 Nov 2020 00:13:00 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 05 Nov 2020 11:12:55 +1100
Subject: [PATCH/RFC] Does nfsiod need WQ_CPU_INTENSIVE?
Message-ID: <87sg9or794.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,
 I have a customer report of NFS getting stuck due to a workqueue
 lockup.

 This appears to be triggered by calling 'close' on a 5TB file.
 The rpc_release set up by nfs4_do_close() calls a final iput()
 on the inode which leads to nfs4_evict_inode() which calls
 truncate_inode_pages_final().  On a 5TB file, this can take a little
 while.

 Documentation for workqueue says
   Generally, work items are not expected to hog a CPU and consume many
   cycles.

 so maybe that isn't a good idea.
 truncate_inode_pages_final() does call cond_resched(), but workqueue
 doesn't take notice of that.  By default it only runs more threads on
 the same CPU if the first thread actually sleeps.  So the net result is
 that there are lots of rpc_async_schedule tasks queued up behind the
 iput, waiting for it to finish rather than running concurrently.

 I believe this can be fixed by setting WQ_CPU_INTENSIVE on the nfsiod
 workqueue.  This flag causes the workqueue core to schedule more
 threads as needed even if the existing threads never sleep.
 I don't know if this is a good idea as it might spans lots of threads
 needlessly when rpc_release functions don't have lots of work to do.

 Another option might be to create a separate nfsiod_intensive_workqueue
 with this flag set, and hand all iput requests over to this workqueue.

 I've asked for the customer to test with this simple patch.

 Any thoughts or suggestions most welcome,

Thanks,
NeilBrown


diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b9d0921cb4fe..d40125a28a77 100644
=2D-- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2153,12 +2153,14 @@ EXPORT_SYMBOL_GPL(nfsiod_workqueue);
=20
 /*
  * start up the nfsiod workqueue
+ * WQ_CPU_INTENSIVE is needed because we might call iput()
+ * which might spend a lot of time tearing down a large file.
  */
 static int nfsiod_start(void)
 {
 	struct workqueue_struct *wq;
 	dprintk("RPC:       creating workqueue nfsiod\n");
=2D	wq =3D alloc_workqueue("nfsiod", WQ_MEM_RECLAIM, 0);
+	wq =3D alloc_workqueue("nfsiod", WQ_MEM_RECLAIM | WQ_CPU_INTENSIVE, 0);
 	if (wq =3D=3D NULL)
 		return -ENOMEM;
 	nfsiod_workqueue =3D wq;


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl+jQ4gOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmEag/+PCCW2CB6C+UOO0WTFcVjwaqkDGXfkeOsdB0t
Wyzxia6EcScloXf/YWKM1U0ytwuLoLKlEf/bWTyAqQMkD/d2hoXew0dZZePszLlO
jAP6X9GHz6tz+Ih9Ke3R1ciQtugS9KIG4IjdlJgB+Q5N+RZHC1o3xc6h+06XQM6N
6d7qX8uCUGYnn7eiqQea8TT4iM7Vb3jBCN8vkelXR3jFz6DCCpjIX+XU/Ft1VNcX
Rq8/Hhluhwn6fpwNY9HZrkaaqTmemiDZ8n8c3fVOz1mnCG5LLyomixiXiHIjeLfz
lWfK8zppNx/LXcSoTPxg8Bu1ecUpFQgFgi5FTHXy3HfhAdUv3kEd1XdXipGBoYJ9
HGL6r2icAPxo1w3bB/u1T1GP82olAjjOe0hV5nS0J715yfzJXQ6CFUDIWQCoarS0
HU4duc+wfFnBA+qsd/PHgO1QxmbJPJprJtZookD/h0Xi2TM7hxp9nSVOZl6O6krH
Uxyr+QHOpVMHMLe6NMHy77KLQGuQrbAIr27RpbMvU8CLg5O/IktDYSu82cIOR7Cg
v38E7evWM0Uox56i3/u/Un6XlNFxIPneVR0ePzddn+HS4lzEyQf92NDO3wcAgy8Z
/i9cJcS+IbioCL82PwIpGzr+b7ZELGnZDeBdNCrr4y+POvkovlGGkFIotzRALHoQ
hm5oM2o=
=Y2BX
-----END PGP SIGNATURE-----
--=-=-=--
