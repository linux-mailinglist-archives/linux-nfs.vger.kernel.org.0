Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F58279DC5
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2019 03:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfG3BPD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jul 2019 21:15:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:45554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728351AbfG3BPD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Jul 2019 21:15:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF946AC0C;
        Tue, 30 Jul 2019 01:15:01 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Tue, 30 Jul 2019 11:14:55 +1000
Cc:     Dave Wysochanski <dwysocha@redhat.com>,
        Neil F Brown <nfbrown@suse.com>, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH] SUNRPC: Track writers of the 'channel' file to improve cache_listeners_exist
In-Reply-To: <20190730004944.GA24355@fieldses.org>
References: <20190725185421.GA15073@fieldses.org> <1564180381-9916-1-git-send-email-dwysocha@redhat.com> <20190729215154.GI20723@fieldses.org> <8736iomlsy.fsf@notabene.neil.brown.name> <20190730004944.GA24355@fieldses.org>
Message-ID: <87tvb4l3w0.fsf@notabene.neil.brown.name>
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

On Mon, Jul 29 2019,  J. Bruce Fields  wrote:

> On Tue, Jul 30, 2019 at 10:02:37AM +1000, NeilBrown wrote:
>> On Mon, Jul 29 2019,  J. Bruce Fields  wrote:
>>=20
>> > On Fri, Jul 26, 2019 at 06:33:01PM -0400, Dave Wysochanski wrote:
>> >> The sunrpc cache interface is susceptible to being fooled by a rogue
>> >> process just reading a 'channel' file.  If this happens the kernel
>> >> may think a valid daemon exists to service the cache when it does not.
>> >> For example, the following may fool the kernel:
>> >> cat /proc/net/rpc/auth.unix.gid/channel
>> >>=20
>> >> Change the tracking of readers to writers when considering whether a
>> >> listener exists as all valid daemon processes either open a channel
>> >> file O_RDWR or O_WRONLY.  While this does not prevent a rogue process
>> >> from "stealing" a message from the kernel, it does at least improve
>> >> the kernels perception of whether a valid process servicing the cache
>> >> exists.
>> >>=20
>> >> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
>> >> ---
>> >>  include/linux/sunrpc/cache.h |  6 +++---
>> >>  net/sunrpc/cache.c           | 12 ++++++++----
>> >>  2 files changed, 11 insertions(+), 7 deletions(-)
>> >>=20
>> >> diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cach=
e.h
>> >> index c7f38e8..f7d086b 100644
>> >> --- a/include/linux/sunrpc/cache.h
>> >> +++ b/include/linux/sunrpc/cache.h
>> >> @@ -107,9 +107,9 @@ struct cache_detail {
>> >>  	/* fields for communication over channel */
>> >>  	struct list_head	queue;
>> >>=20=20
>> >> -	atomic_t		readers;		/* how many time is /chennel open */
>> >> -	time_t			last_close;		/* if no readers, when did last close */
>> >> -	time_t			last_warn;		/* when we last warned about no readers */
>> >> +	atomic_t		writers;		/* how many time is /channel open */
>> >> +	time_t			last_close;		/* if no writers, when did last close */
>> >> +	time_t			last_warn;		/* when we last warned about no writers */
>> >>=20=20
>> >>  	union {
>> >>  		struct proc_dir_entry	*procfs;
>> >> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
>> >> index 6f1528f..a6a6190 100644
>> >> --- a/net/sunrpc/cache.c
>> >> +++ b/net/sunrpc/cache.c
>> >> @@ -373,7 +373,7 @@ void sunrpc_init_cache_detail(struct cache_detail=
 *cd)
>> >>  	spin_lock(&cache_list_lock);
>> >>  	cd->nextcheck =3D 0;
>> >>  	cd->entries =3D 0;
>> >> -	atomic_set(&cd->readers, 0);
>> >> +	atomic_set(&cd->writers, 0);
>> >>  	cd->last_close =3D 0;
>> >>  	cd->last_warn =3D -1;
>> >>  	list_add(&cd->others, &cache_list);
>> >> @@ -1029,11 +1029,13 @@ static int cache_open(struct inode *inode, st=
ruct file *filp,
>> >>  		}
>> >>  		rp->offset =3D 0;
>> >>  		rp->q.reader =3D 1;
>> >> -		atomic_inc(&cd->readers);
>> >> +
>> >>  		spin_lock(&queue_lock);
>> >>  		list_add(&rp->q.list, &cd->queue);
>> >>  		spin_unlock(&queue_lock);
>> >>  	}
>> >> +	if (filp->f_mode & FMODE_WRITE)
>> >> +		atomic_inc(&cd->writers);
>> >
>> > This patch would be even simpler if we just modified the condition of
>> > the preceding if clause:
>> >
>> > -	if (filp->f_mode & FMODE_READ) {
>> > +	if (filp->f_mode & FMODE_WRITE) {
>> >
>> > and then we could drop the following chunk completely.
>> >
>> > Is there any reason not to do that?
>>=20
>> I can see how this would be tempting, but I think the reason not to do
>> that is it is ... wrong.
>>=20
>> The bulk of the code is for setting up context to support reading, so it
>> really should be conditional on FMODE_READ.
>> We always want to set that up, because if a process opens for read, and
>> not write, we want to respond properly to read requests.  This is useful
>> for debugging.
>
> How is it useful for debugging?

I often ask for

   grep . /proc/net/rpc/*/*

If nothing is reported for "channel", then I know that the problem isn't
that mountd is dead or stuck or similar.

NeilBrown


>
> --b.
>
>> I think this patch from Dave is good.  A process opening for read might
>> just be inquisitive.  A program opening for write is making more of a
>> commitment to being involved in managing the cache.
>>=20
>>  Reviewed-by: NeilBrown <neilb@suse.com>
>>=20
>> Thanks,
>> NeilBrown
>>=20
>>=20
>> >
>> > Or if the resulting behavior isn't right for write-only openers, we
>> > could make the condition ((filp->f_mode & FMODE_READ) && (filp->f_mode=
 &
>> > FMODE_WRITE)).
>> >
>> > --b.
>> >
>> >>  	filp->private_data =3D rp;
>> >>  	return 0;
>> >>  }
>> >> @@ -1062,8 +1064,10 @@ static int cache_release(struct inode *inode, =
struct file *filp,
>> >>  		filp->private_data =3D NULL;
>> >>  		kfree(rp);
>> >>=20=20
>> >> +	}
>> >> +	if (filp->f_mode & FMODE_WRITE) {
>> >> +		atomic_dec(&cd->writers);
>> >>  		cd->last_close =3D seconds_since_boot();
>> >> -		atomic_dec(&cd->readers);
>> >>  	}
>> >>  	module_put(cd->owner);
>> >>  	return 0;
>> >> @@ -1171,7 +1175,7 @@ static void warn_no_listener(struct cache_detai=
l *detail)
>> >>=20=20
>> >>  static bool cache_listeners_exist(struct cache_detail *detail)
>> >>  {
>> >> -	if (atomic_read(&detail->readers))
>> >> +	if (atomic_read(&detail->writers))
>> >>  		return true;
>> >>  	if (detail->last_close =3D=3D 0)
>> >>  		/* This cache was never opened */
>> >> --=20
>> >> 1.8.3.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl0/mg8ACgkQOeye3VZi
gbmttA/+KM1EEKydWYlyUyMj++MvUyCjXCHKRj1sINIr+3tI8Ti2FngWbid6awHr
gbIjhD1KmafqnT2QftxHOwXUKnHESpgWidf/Egq4C7H+fpUNeKwtegXOPDuBcG+s
mHIPCB8XMIgsf8Iv7xcQvtze5c62LdjCRWbzaJoqWC9DoI6e6wlqsEToD3DdH4QZ
6Kmsh8nBb6F+ogbR+FW+5sBrWzDQbRTavlUfIyV2pjcMPgW8xFdvNCj53M3vyvu1
XAxnuqqGzHDPe0CJWeeRaZ9XrcDJhV6sdoIJB/CJ80RK1IDSfqcthJLKmlzk6lf7
TXx4IBdwWR6UMRvRBGlgp75/h3bYTS0NKnOYuUviIR5pH5ZZkf+3wyba7IirFma1
7ObarHXd+35OP8hCWlMqemW+M1X0Dk/Q04VH5wM4Yqsbp1SxUOI+XHgtK1rlQP5d
ER8XLvezKkyinQN1GWANGpm82+FXX+bkWctfLeSvoDJBgpFn92/h8NKjhoncDqu5
bAO6GnR39wEaB8QD9d6Hqx/f7F9LNauD8jLaryvtin7+6Y7iAqyYvbUHXkYPrzoA
/+kQwDXjli70KEJG7EE1la+Vnsa/3fOgLcoJctBcyD0c15Wx9QOPGJGRPWQQW3Uz
2SHx2lyoZsVy/4TtVy5FYXSwS5XzlA/cNoafPq70JGxiRa457b8=
=Hy5e
-----END PGP SIGNATURE-----
--=-=-=--
