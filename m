Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C9847B251
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Dec 2021 18:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbhLTRrg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Dec 2021 12:47:36 -0500
Received: from mta-202b.oxsus-vadesecure.net ([51.81.232.241]:33615 "EHLO
        nmtao202.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232037AbhLTRrf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Dec 2021 12:47:35 -0500
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Dec 2021 12:47:35 EST
DKIM-Signature: v=1; a=rsa-sha256; bh=Ujh1bCIvozHgwZbdMQ8ASieY/9vp2w0IZWVDbg
 G61Xo=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1640022127;
 x=1640626927; b=Q7ZO3zO4Wm3ImAOC7+eqA9CnmPaVnoZuTRx74ItWXQuwX8ilHyzbla+
 IVMuBHtwp2zCbm/Bl85QitaqC3OBPVO3fOKAmtifKjQVknZT+wNKH1+euzIjH4fYt7ACtGJ
 hFcp4YVp1B7mX9VH8uyHxyxDgA+44kZtqLEW+0fc6urQJuGceKxlFMqOlSr4t1S7F9CSQZS
 BQvv98hKIOHH6WnagYM/0K6/d6hZrUNTg0cQhIMoSRQKdngYf2765Fy85Kwwzi/1zmEeQ0q
 yej+qOOz2uQg5USb+nZ6DYseoHLiaVmu7kd++KlKhVGsaN+dRqBVdLVYRA6C56quOEHmGw5
 wGA==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus2nmtao02p with ngmta
 id 8096ba65-16c2876f9a62a585; Mon, 20 Dec 2021 17:42:07 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Bruce Fields'" <bfields@redhat.com>, <trondmy@kernel.org>
Cc:     "'Chuck Lever'" <chuck.lever@oracle.com>,
        "'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>
Subject: pynfs V3 ideas - WAS: [PATCH 5/9] nfsd: NFSv3 should allow zero length writes
Date:   Mon, 20 Dec 2021 09:42:07 -0800
Message-ID: <0f7201d7f5c8$e913c410$bb3b4c30$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: Adf1yNYzYpH/AIhFRuKlSZspDRoFjw==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Fri, Dec 17, 2021 at 5:07 PM <trondmy@kernel.org> wrote:
> >
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >
> > According to RFC1813: "If count is 0, the WRITE will succeed and
> > return a count of 0, barring errors due to permissions checking."
>=20
> Yes, I'm surprised we're not already doing this right.
>=20
> I wonder how far back this bug goes.
>=20
> The svc.c code is from 8154ef2776aa "NFSD: Clean up legacy NFS WRITE
> argument XDR decoders", but the behavior might predate that code.  The
> nfsd_vfs_write() logic, I'm not sure I understand.
>=20
> We have a pynfs test for the v4 case (WRT4), but I guess we must have =
nothing
> testing the v3 case.

Hmm, need to try and remember this... I am slowly working on pnfs V3 =
test cases so I will try and make sure edge cases like this get tested.

Frank

