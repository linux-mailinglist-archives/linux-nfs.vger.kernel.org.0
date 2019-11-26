Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99C6410A145
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2019 16:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfKZPe7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Nov 2019 10:34:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40574 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727028AbfKZPe7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Nov 2019 10:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574782497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tRr5W9SzHoHxfAKocFkoLKzxEtAuNgC2rzziEo9gOjM=;
        b=HakK3pbY4torboULzSZ4FrYHZ1L5hnF7YHBkmnLS5hR5X1/zYXSS5gjOuQWtJ3D+jB407P
        BKkKP8ZM1VavGaVSov0zv/PiRfQQuItsjBlgDalK17Q6tAnrCNWK3xTaJ+h4XhdtkGQzbd
        O5VdNSh4KKe03vJ4DdBAzy4df/Bbg9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-5UvZwR6DPjGxN0b2y7qZGg-1; Tue, 26 Nov 2019 10:34:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 415CD8017CC;
        Tue, 26 Nov 2019 15:34:51 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-117-193.phx2.redhat.com [10.3.117.193])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 076E35D6D0;
        Tue, 26 Nov 2019 15:34:50 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 0637C120191; Tue, 26 Nov 2019 10:34:50 -0500 (EST)
Date:   Tue, 26 Nov 2019 10:34:49 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Doug Nazar <nazard@nazar.ca>
Cc:     linux-nfs@vger.kernel.org, Thomas Deutschmann <whissi@gentoo.org>,
        Steve Dickson <steved@redhat.com>
Subject: Re: nfs-utils: v3 mounts broken due to statx() returning EINVAL
Message-ID: <20191126153449.GA68204@pick.fieldses.org>
References: <20191011170709.GE19318@fieldses.org>
 <dd522611-f8eb-bb94-9ec6-09a6725e8cca@nazar.ca>
MIME-Version: 1.0
In-Reply-To: <dd522611-f8eb-bb94-9ec6-09a6725e8cca@nazar.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 5UvZwR6DPjGxN0b2y7qZGg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 26, 2019 at 02:22:40AM -0500, Doug Nazar wrote:
> On Fri, Oct 11, 2019 at 17:07:09PM +0000, Bruce Fields wrote:
> >On Tue, Oct 08, 2019 at 10:23:56PM +0200, Thomas Deutschmann wrote:
> >> Hi,
> >>
> >> we have some user reporting that NFS v3 mounts are broken
> >> when using glibc-2.29 and linux-4.9.x (4.9.128) because
> >> statx() with mask=3DSTATX_BASIC_STATS returns EINVAL.
> >>
> >> Looks like this isn't happening with <nfs-utils-2.4.1 or
> >> newer kernels.
> >>
> >> The following workaround was confirmed to be working:
> >>
> >> --- a/support/misc/xstat.c=A0=A0=A0 2019-06-24 21:31:55.260371592 +020=
0
> >> +++ b/support/misc/xstat.c=A0=A0=A0 2019-06-24 21:32:29.098777436 +020=
0
> >> @@ -47,6 +47,8 @@
> >>=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 statx_copy(statbuf, &stxbuf);
> >>=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return 0;
> >>=A0 =A0=A0=A0 =A0=A0=A0 }
> >> +=A0=A0=A0 =A0=A0=A0 if (errno =3D=3D EINVAL)
> >> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 errno =3D ENOSYS;
> >>=A0 =A0=A0=A0 =A0=A0=A0 if (errno =3D=3D ENOSYS)
> >>=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 statx_supported =3D 0;
> >>=A0 =A0=A0=A0 } else
> >>
> >>
> >> Bug: https://bugs.gentoo.org/688644
> >>
> >> At the moment I have no clue whether this is kernel/glibc or
> >> nfs-utils related; if the patch is safe to apply...
> >
> >Well, sounds like nfs-utils started using statx in 2.4.1.=A0 And just th=
e
> >fact that varying the kernel version makes it sound like there was a
> >kernel bug causing an EINVAL return in this case, and that bug got
> >fixed.
> >
> >One way to confirm might be running mount under strace and looking for
> >that EINVAL return.
>=20
> Just to provide an update on this issue, it was tracked down to glibc's
> statx emulation not supporting AT_STATX_DONT_SYNC and returning EINVAL.
>=20
> So on a kernel without statx support, but a new glibc with statx support,
> nfs-utils will always fail to stat any paths.
>=20
> Either this or a similar fix is required to support older kernels.

OK.  So maybe your patch is the best we can do.  I'd just add a comment
there documenting the situation.

--b.

