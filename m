Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2B24AA185
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Feb 2022 22:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbiBDVCR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Feb 2022 16:02:17 -0500
Received: from mta-201b.oxsus-vadesecure.net ([51.81.229.181]:52669 "EHLO
        nmtao201.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232318AbiBDVCQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Feb 2022 16:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; bh=gEfQ4DHryz7UCWYdLV7JBM+TTUpuJX289YX71H
 xq3KA=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1644008532;
 x=1644613332; b=kPc7pD8rjBbr4WvImZPBOXQx3+M6wAyjugayfC9l2XorZe3Nr2zBi9v
 S2kxyVf0IAF3vwSV8wyBwzQHGcMCbxGwgzUvMsXOHHrq33KaM8S72hJvpJnhqbUynYu+pRV
 nia6Adi+2Jg9N/RZI00fH3xYqLuwBKBtxFPcxNap+evh7Z2Jj1bXTP156vv2MB8IcD91Uaq
 Q6sg4vnKqTs/Q2RpAab684LykUO9+0hK/PVECNoAMFVt3GNtYY62lOKRCJXcMmpO3JFEF3B
 aFxp39pQz8gehVb/Bz7uoUCUqMgVzV0XMxecNvqdpBOf5DUAHrqUbXSty0+9h+zLxdxDbpu
 1aA==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus2nmtao01p with ngmta
 id 197d1dcd-16d0b10cd53886d2; Fri, 04 Feb 2022 21:02:12 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Chuck Lever'" <chuck.lever@oracle.com>, <bfields@fieldses.org>
Cc:     <linux-nfs@vger.kernel.org>
References: <164400374422.1026143.17746475126462213720.stgit@morisot.1015granger.net>
In-Reply-To: <164400374422.1026143.17746475126462213720.stgit@morisot.1015granger.net>
Subject: RE: [PATCH] Permit COMMIT operations to return NFS4_OK
Date:   Fri, 4 Feb 2022 13:02:12 -0800
Message-ID: <0ec101d81a0a$7bdfa880$739ef980$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQIf1eootFfPAesAqllEKesc4wY5pKv0aJIw
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> RFC 7530 permits COMMIT to return NFS4ERR_INVAL, but RFC 5661 and =
later do
> not. Allow INVAL as a legacy behavior, but test for OK also.

Do we have a 4.1 test to verify 4.1 and later doesn't return INVAL?

Frank

> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  nfs4.0/servertests/st_commit.py |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/nfs4.0/servertests/st_commit.py =
b/nfs4.0/servertests/st_commit.py
> index 12a0dffa061f..4ef87e69c5d7 100644
> --- a/nfs4.0/servertests/st_commit.py
> +++ b/nfs4.0/servertests/st_commit.py
> @@ -160,4 +160,4 @@ def testCommitOverflow(t, env):
>      res =3D c.write_file(fh, _text, 0, stateid, how=3DUNSTABLE4)
>      check(res, msg=3D"WRITE with how=3DUNSTABLE4")
>      res =3D c.commit_file(fh, 0xfffffffffffffff0, 64)
> -    check(res, NFS4ERR_INVAL, "COMMIT with offset + count overflow")
> +    check(res, [NFS4_OK, NFS4ERR_INVAL], "COMMIT with offset + count
> + overflow")


