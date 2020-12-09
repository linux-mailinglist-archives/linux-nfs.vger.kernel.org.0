Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5717C2D4693
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 17:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgLIQRm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 11:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgLIQRe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Dec 2020 11:17:34 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A158C0613D6
        for <linux-nfs@vger.kernel.org>; Wed,  9 Dec 2020 08:16:54 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id h20so1720391qkk.4
        for <linux-nfs@vger.kernel.org>; Wed, 09 Dec 2020 08:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bxwWO+xY0YEM3R3Oqq4dhQrOc0Q7/BBq1aaVf2/lOng=;
        b=aUVpbPzxx5R6xNBNxpK6z5o9HdoxRVTc1Fgd37dHbCbVqrGueheT6VINvod9n9qZf7
         s5JQYMgmBpitr7bYE3pDjRPDDAH6q0e7diRNxKOHswvR4gdWkqXal+LKdU5dLxxJ79dd
         DuXSc+orkG+BXmUJc9X/Qni6oyc/rOpzvcQS8SrRum7BC4Ab47SkRJgC8Moxto1TZJP/
         FPChAO7bS5RvoE2PvBggKu+LT1JSZv1imYt66EyndyG70E8pANczkZPcuX3JWt2ptC9Q
         2Mz5ruIxkJkm94t62xels1IwaNLvqPZbG4v9ouhKo89MvZkzG24bRB688Pqv0ibk9fCG
         vQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bxwWO+xY0YEM3R3Oqq4dhQrOc0Q7/BBq1aaVf2/lOng=;
        b=Vg82EpSDcykd8bFbRUWzXqonJYbvXb8BrTtcu641y4ZegCXxO0lyRnn/BWm3KW6mQm
         kPVd5LhbW4DypMofBsMw5oHdsF+ZjSmEJpiX73hUMttJ8qBKNTNHQ/c+2j4n7Sb7KL47
         pdRgW2gMQ4otpdfHTbj/CbqH0G5R8dUXM0XRvoiDlVFCJAjJzkxAeruO4v4cgk8uoppq
         0VXiRcz1e75Qdz9l04id/GFBBknw/vWqdLRTQR8hHI5eeCPwfPOsyOil/R4hP0lAwOKq
         LNdYBP/zpfagMv+7SQRvu5ntUvbldhRomylJSkynuddLOQo7yyw0EScDzCvq94TY+Dzr
         ij7A==
X-Gm-Message-State: AOAM530rfcIAGR+zjTjlA6eAxmXgvfvMBgZvNrMBQSRLJycU9eVSbM4W
        85F7qxI54yrJBOJcscK3hH4=
X-Google-Smtp-Source: ABdhPJw+u+Sz3OXJgYg/CVQ286OkV2sq71QQYlrCr6+Q97qpRRY4oCmQtzipLMFnJk2EaQq7kSZQBg==
X-Received: by 2002:a05:620a:5ad:: with SMTP id q13mr3817369qkq.135.1607530613776;
        Wed, 09 Dec 2020 08:16:53 -0800 (PST)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b19sm1218512qtr.39.2020.12.09.08.16.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 08:16:52 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 15/16] nfsd: Fixes for nfsd4_encode_read_plus_data()
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20201209144801.700778-16-trondmy@kernel.org>
Date:   Wed, 9 Dec 2020 11:16:50 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4BA2AAC7-C4F5-4740-B10F-D34022A58722@gmail.com>
References: <20201209144801.700778-1-trondmy@kernel.org>
 <20201209144801.700778-2-trondmy@kernel.org>
 <20201209144801.700778-3-trondmy@kernel.org>
 <20201209144801.700778-4-trondmy@kernel.org>
 <20201209144801.700778-5-trondmy@kernel.org>
 <20201209144801.700778-6-trondmy@kernel.org>
 <20201209144801.700778-7-trondmy@kernel.org>
 <20201209144801.700778-8-trondmy@kernel.org>
 <20201209144801.700778-9-trondmy@kernel.org>
 <20201209144801.700778-10-trondmy@kernel.org>
 <20201209144801.700778-11-trondmy@kernel.org>
 <20201209144801.700778-12-trondmy@kernel.org>
 <20201209144801.700778-13-trondmy@kernel.org>
 <20201209144801.700778-14-trondmy@kernel.org>
 <20201209144801.700778-15-trondmy@kernel.org>
 <20201209144801.700778-16-trondmy@kernel.org>
To:     trondmy@kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey-

> On Dec 9, 2020, at 9:48 AM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Ensure that we encode the data payload + padding, and that we truncate
> the preallocated buffer to the actual read size.

Did you intend to merge 15/16 and 16/16 through your tree?

Can the patch descriptions say a little more about why these
changes are necessary? If they fix a misbehavior, describe
the problem.


> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> fs/nfsd/nfs4xdr.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 833a2c64dfe8..26f6e277101d 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4632,6 +4632,7 @@ nfsd4_encode_read_plus_data(struct =
nfsd4_compoundres *resp,
> 			    resp->rqstp->rq_vec, read->rd_vlen, =
maxcount, eof);
> 	if (nfserr)
> 		return nfserr;
> +	xdr_truncate_encode(xdr, starting_len + 16 + =
xdr_align_size(*maxcount));
>=20
> 	tmp =3D htonl(NFS4_CONTENT_DATA);
> 	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
> @@ -4639,6 +4640,10 @@ nfsd4_encode_read_plus_data(struct =
nfsd4_compoundres *resp,
> 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
> 	tmp =3D htonl(*maxcount);
> 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
> +
> +	tmp =3D xdr_zero;
> +	write_bytes_to_xdr_buf(xdr->buf, starting_len + 16 + *maxcount, =
&tmp,
> +			       xdr_pad_size(*maxcount));
> 	return nfs_ok;
> }
>=20
> --=20
> 2.29.2
>=20

--
Chuck Lever
chucklever@gmail.com



