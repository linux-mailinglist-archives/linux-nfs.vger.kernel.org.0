Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C36E309F92
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Feb 2021 00:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhAaXqX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 31 Jan 2021 18:46:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:60766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhAaXqT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 31 Jan 2021 18:46:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5A490AC4F;
        Sun, 31 Jan 2021 23:45:36 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 01 Feb 2021 10:45:31 +1100
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: releasing result pages in svc_xprt_release()
In-Reply-To: <597824E7-3942-4F11-958F-A6E247330A9E@oracle.com>
References: <811BE98B-F196-4EC1-899F-6B62F313640C@oracle.com>
 <87im7ffjp0.fsf@notabene.neil.brown.name>
 <597824E7-3942-4F11-958F-A6E247330A9E@oracle.com>
Message-ID: <878s88fz6s.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 29 2021, Chuck Lever wrote:

>> On Jan 29, 2021, at 5:43 PM, NeilBrown <neilb@suse.de> wrote:
>>=20
>> On Fri, Jan 29 2021, Chuck Lever wrote:
>>=20
>>> Hi Neil-
>>>=20
>>> I'd like to reduce the amount of page allocation that NFSD does,
>>> and was wondering about the release and reset of pages in
>>> svc_xprt_release(). This logic was added when the socket transport
>>> was converted to use kernel_sendpage() back in 2002. Do you
>>> remember why releasing the result pages is necessary?
>>>=20
>>=20
>> Hi Chuck,
>> as I recall, kernel_sendpage() (or sock->ops->sendpage() as it was
>> then) takes a reference to the page and will hold that reference until
>> the content has been sent and ACKed.  nfsd has no way to know when the
>> ACK comes, so cannot know when the page can be re-used, so it must
>> release the page and allocate a new one.
>>=20
>> This is the price we pay for zero-copy, and I acknowledge that it is a
>> real price.  I wouldn't be surprised if the trade-offs between
>> zero-copy and single-copy change over time, and between different
>> hardware.
>
> Very interesting, thanks for the history! Two observations:
>
> - I thought without MSG_DONTWAIT, the sendpage operation would be
> total synchronous -- when the network layer was done with retransmissions,
> it would unblock the caller. But that's likely a mistaken assumption
> on my part. That could be why sendmsg is so much slower than sendpage
> in this particular application.
>

On the "send" side, I think MSG_DONTWAIT is primarily about memory
allocation.  send_msg() can only return when the message is queued.  If
it needs to allocate memory (or wait for space in a restricted queue),
then MSG_DONTWAIT says "fail instead".  It certainly doesn't wait for
successful xmit and ack.
On the "recv" side it is quite different of course.

> - IIUC, nfsd_splice_read() replaces anonymous pages in rq_pages with
> actual page cache pages. Those of course cannot be used to construct
> subsequent RPC Replies, so that introduces a second release requirement.

Yep.  I wonder if those pages are protected against concurrent updates
.. so that a computed checksum will remain accurate.

>
> So I have a way to make the first case unnecessary for RPC/RDMA. It
> has a reliable Send completion mechanism. Sounds like releasing is
> still necessary for TCP, though; maybe that could be done in the
> xpo_release_rqst callback.

It isn't clear to me what particular cost you are trying to reduce.  Is
handing a page back from RDMA to nfsd cheaper than nfsd calling
alloc_page(), or do you hope to keep batches of pages together to avoid
multi-page overheads, or is this about cache-hot pages, or ???

>
> As far as nfsd_splice_read(), I had thought of moving those pages to
> a separate array which would always be released. That would need to
> deal with the transport requirements above.
>
> If nothing else, I would like to add mention of these requirements
> somewhere in the code too.

Strongly agree with that.

>
> What's your opinion?

To form a coherent opinion, I would need to know what that problem is.
I certainly accept that there could be performance problems in releasing
and re-allocating pages which might be resolved by batching, or by copying,
or by better tracking.  But without knowing what hot-spot you want to
cool down, I cannot think about how that fits into the big picture.
So: what exactly is the problem that you see?

Thanks,
NeilBrown


>
>
> --
> Chuck Lever

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmAXQRwOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbm/5g//VnCiYNAm1U02K3RsE+30dsK9rKHYUsZC3YL0
oqJRJ+xst4qgaF3/n3kPgu6w5tdVvr1G5hWK02+VJbm/yUkAkz8MI1nnfXzWqcjt
atdnaAMfb2a9tGG1On7S1aH79E2P/tNUFrD6faki8lAmlCaeVbgNVjD6PvN2W8Ak
hxuCAnGL1Ah54Ma3t4TFBfQ0fqII+NdUgwjpV3EBY8zIxNi43p7NzyZ8+U+9FhTZ
q/pJI11Vm8JDWlQBOR/VBNJZlidAFLz8/HkBWgVB4cTs4VzSHkF7zzGP//H6pChl
XHIOGU4x4IpuRdkEkRfGn4LkFlZpsw3DPCr/dkHasAITL63Y2t/HyMj9W20faCU0
C1hWYGNqw/aQc44jardvV3nCpQwNusAUOI9fliZOh9BX/1wYi9PaxFJMXozSVS5n
UWwhG5nWSYzI6/l0o4ArviBQw+SWFgul0v6mK8hDjWWJWbYt8iFls86SDU4rQFgt
QeLu8ggx7c/33fnbtPvGbj7nyUFqwFTIC5eEXl0Qp2UM53tK2kNF69Wiol9WiZqX
vP2wLNerAUoWvloKaS8fpZRYg7kBUQraO30/NqxKfXQZlm0iuzjB4sB+0BCf7+3C
197SO6LX1oM4UWtJzBnP4ypEtDH8nmWoqt+FICELYl3MbboswqoajBeVNoxhTAL+
LAEOuuU=
=p+KS
-----END PGP SIGNATURE-----
--=-=-=--
