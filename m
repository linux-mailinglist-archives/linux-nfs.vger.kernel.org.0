Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C032D474C
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 18:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbgLIQ6p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 11:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732060AbgLIQ6l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Dec 2020 11:58:41 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43354C0613D6
        for <linux-nfs@vger.kernel.org>; Wed,  9 Dec 2020 08:58:01 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id n9so906827qvp.5
        for <linux-nfs@vger.kernel.org>; Wed, 09 Dec 2020 08:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TZ8nZxsSks0yV5KHeBL+hIjKLtwdkcyWLg8oG8yvAY0=;
        b=Y0o2gov62YU1VtUP8RzYTmT1c9wpBA9YSe/9yCtGTD79WwZb/vkDzcJKCGrdFyR3x2
         XklDbaq8AMvOnE+LcW/YJLccPlCQKneqVIMD7SNXfO+NdpS5CGQoL2ORYKXi5zvgpy9f
         m5IfbSGBigvX5oFUFT6ISR91Jjw5gBgB65nPB8BwlXviIjg7o1siwj83vhybqjQcF2no
         XdrsnU8lzwzIv/gDfd2GIYigJBfYMIHQieFhHDT3S0e+JM7bQBas4TDukSyL2MEFo2U9
         AQx6retu46fKRG2Iu3d5zWMZf1kxzotjDxFSL8l7iFkulG2oolgrsMnq6JRJ/bi7Y2l0
         3B1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TZ8nZxsSks0yV5KHeBL+hIjKLtwdkcyWLg8oG8yvAY0=;
        b=slz6HsoK+2BNDsbZ3TXAzGfP4/p4fQG9n7y0bY1n9Zt7pLAstJhwsd9XYc4rH4dbwO
         nrGs5vSFZeOgWRbd2yTclKKB/8daFW+w+2pgvhgpzii09YKXEqfZdCyQMqhOY9l9SqNp
         p/55S8uJaBsKFeriafH8oM4b6fofnhNtAOdxB49zTN94xI3JHfvkjMgxhc98DeC9urWU
         ikMK2vgg7BV74Y8S/1gRWjpfnVmlzMRF1lPx09h3OCT09cetsk/fTtHwsTrs6S5OqOG1
         ASD6WDSnG4GzM3dw5FCa9Y1ebG/njk0/Cuoeh08O5K23Gz9RmgfiW84JIedMnyxaj3qa
         ajzA==
X-Gm-Message-State: AOAM533rKaGe3G5GpM520e2x6NNL0ToitQ6t6Dba+xk8r4GOLXW2gvKM
        bQ6GmmhGqlNXmEsLkhGUld4evHeHHak=
X-Google-Smtp-Source: ABdhPJyyI2EYMFgu4BdSe1NKw6iS7rrrqlC4VrZK6PZDH7HEOt1YrcI7yTItBeGkoSU4+epYtMmb5A==
X-Received: by 2002:ad4:5188:: with SMTP id b8mr3988787qvp.55.1607533080507;
        Wed, 09 Dec 2020 08:58:00 -0800 (PST)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v5sm1365722qkf.133.2020.12.09.08.57.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 08:57:59 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 15/16] nfsd: Fixes for nfsd4_encode_read_plus_data()
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <55246c5db6ec550827f1f230bd980760db28a689.camel@hammerspace.com>
Date:   Wed, 9 Dec 2020 11:57:56 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DF972250-F1EA-4996-8CEB-18171BD346C2@gmail.com>
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
 <4BA2AAC7-C4F5-4740-B10F-D34022A58722@gmail.com>
 <55246c5db6ec550827f1f230bd980760db28a689.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 9, 2020, at 11:39 AM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Wed, 2020-12-09 at 11:16 -0500, Chuck Lever wrote:
>> Hey-
>>=20
>>> On Dec 9, 2020, at 9:48 AM, trondmy@kernel.org wrote:
>>>=20
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>=20
>>> Ensure that we encode the data payload + padding, and that we
>>> truncate
>>> the preallocated buffer to the actual read size.
>>=20
>> Did you intend to merge 15/16 and 16/16 through your tree?
>=20
> No. They can go through the nfsd tree. I included them here because
> they are necessary in order to pass the xfstests.

Would it be OK if they went in 5.11-rc? I've got the initial
merge tag prepared already. If they can't wait, let me know.


>> Can the patch descriptions say a little more about why these
>> changes are necessary? If they fix a misbehavior, describe
>> the problem.
>=20
> It's the same problem and solution that exists in the READ code.
>=20
> nfsd_readv() doesn't necessarily return the same number of bytes that
> we requested and preallocated buffer space for. So to deal with that,
> we have to truncate the preallocated buffer.

Huh. I thought it was doing that already? Oh, that's just for
the cases where the server returns an error status. The
READ_PLUS encoder incorrectly does not do that truncation for
short READs... got it.


> Finally, we have to write zeros into the padding bytes after the read
> buffer.

Right. Then the problem statement is that the server's READ_PLUS
XDR encoder isn't padding the read buffer properly.

Quibble: perhaps these are two separate issues that each deserve
their own patches with Fixes: tags (and if you re-post these,
please add a Fixes: tag to 16/16 too).

Thanks!


>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>> fs/nfsd/nfs4xdr.c | 5 +++++
>>> 1 file changed, 5 insertions(+)
>>>=20
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index 833a2c64dfe8..26f6e277101d 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -4632,6 +4632,7 @@ nfsd4_encode_read_plus_data(struct
>>> nfsd4_compoundres *resp,
>>>                             resp->rqstp->rq_vec, read->rd_vlen,
>>> maxcount, eof);
>>>         if (nfserr)
>>>                 return nfserr;
>>> +       xdr_truncate_encode(xdr, starting_len + 16 +
>>> xdr_align_size(*maxcount));
>>>=20
>>>         tmp =3D htonl(NFS4_CONTENT_DATA);
>>>         write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp, =20=

>>> 4);
>>> @@ -4639,6 +4640,10 @@ nfsd4_encode_read_plus_data(struct
>>> nfsd4_compoundres *resp,
>>>         write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64,
>>> 8);
>>>         tmp =3D htonl(*maxcount);
>>>         write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp, =20=

>>> 4);
>>> +
>>> +       tmp =3D xdr_zero;
>>> +       write_bytes_to_xdr_buf(xdr->buf, starting_len + 16 +
>>> *maxcount, &tmp,
>>> +                              xdr_pad_size(*maxcount));
>>>         return nfs_ok;
>>> }
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever
chucklever@gmail.com



