Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E752C8BE6
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 19:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgK3R6W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 12:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgK3R6W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 12:58:22 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB042C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 09:57:41 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id u21so2989749qtw.11
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 09:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UrMw4oKWVr2caQDiqCZs6p2wI9b7V+rbf0CXAyWmTZU=;
        b=Skyin5RAZCsy15/+SPZicUcCnxYvsApRZELJmJHXtWNGM54yPSHfm+lItVcFusgZiX
         DuB0zceJMzBzvNxSLJ9TnAmkR+9XpsFASJsosJSQW2y0zXnhUOwInatnSjCEZg1HAXRn
         hQqWxTyFE0EIZU4iBzH5e9FvB9Qc3K10Xa3LRcQvn5UMQUL9TRyBBFpexVZEHuqBBvlh
         TLPLynjUYURoQW28mBi73LFr91pr76hKExPmVeY8dm138HOUUEYwAWg0GzLDWVaGSgWM
         7JRmWcSwYpOSlky440MLJ4/Ho6gok+eg6ja7T14GwpkkzkW2HzRO7wJBX+ugZdYVVew/
         oMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UrMw4oKWVr2caQDiqCZs6p2wI9b7V+rbf0CXAyWmTZU=;
        b=FzhUQZRfEzRF4pTL8pipYU9xVf4wh8eQtIEyPkyAEPYZLQ6XnCh1yZWEFS0VGqJRJU
         tyaeGUTgq2sJLsbpjXiwsIIg4zaHp3Y0zLtgS3XsIXjlVMApae+J2RHaKA+XzlnonrP1
         Jv2h4dIkcKxwYT0Kon44rhXMnqFQzze/GbNTgA5BnwG4rtLn/P2tI9BV4jnkXERMTFCg
         qAimcO0DS3Ft2GcgST/IA87+F79qEIvVskRygg+lpc8TIkNnRWHfhAzji+dTE8BGG5UV
         MsFJMT3/vsN5ABCo9dZNHG+EtqnBaaAeFi0xLvZY/q+h8+7gxp6ZpLhId7VqmLbHoYi5
         ODjg==
X-Gm-Message-State: AOAM532SoFbaKJiudwamb4cE0vkbVLPhPRdsf/E7MpP6khHHJN6pz2JF
        pihD05pT4xyJqokcnBMxFr4=
X-Google-Smtp-Source: ABdhPJyQraSLXMz3iKSG4ysN02Sm3fHH6B8Z67OPiiULHTcAVZ+7BWfty8Uyka67R7lWkvLL+EAuFg==
X-Received: by 2002:ac8:7445:: with SMTP id h5mr22860975qtr.334.1606759061136;
        Mon, 30 Nov 2020 09:57:41 -0800 (PST)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i4sm16184659qtw.22.2020.11.30.09.57.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 09:57:40 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] NFSD: Fix 5 seconds delay when doing inter server copy
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20201124204956.GB7173@fieldses.org>
Date:   Mon, 30 Nov 2020 12:57:39 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9C1255B8-F52F-4797-9E2E-EF7EBE60C613@gmail.com>
References: <20201124031609.67297-1-dai.ngo@oracle.com>
 <20201124204956.GB7173@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Dai -

> On Nov 24, 2020, at 3:49 PM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Mon, Nov 23, 2020 at 10:16:09PM -0500, Dai Ngo wrote:
>> Since commit b4868b44c5628 ("NFSv4: Wait for stateid updates after
>> CLOSE/OPEN_DOWNGRADE"), every inter server copy operation suffers 5
>> seconds delay regardless of the size of the copy. The delay is from
>> nfs_set_open_stateid_locked when the check by =
nfs_stateid_is_sequential
>> fails because the seqid in both nfs4_state and nfs4_stateid are 0.
>>=20
>> Fix by modifying the source server to return the stateid for =
COPY_NOTIFY
>> request with seqid 1 instead of 0. This is also to conform with
>> section 4.8 of RFC 7862.
>>=20
>> Here is the relevant paragraph from section 4.8 of RFC 7862:
>>=20
>>   A copy offload stateid's seqid MUST NOT be zero.  In the context of =
a
>>   copy offload operation, it is inappropriate to indicate "the most
>>   recent copy offload operation" using a stateid with a seqid of zero
>>   (see Section 8.2.2 of [RFC5661]).  It is inappropriate because the
>>   stateid refers to internal state in the server and there may be
>>   several asynchronous COPY operations being performed in parallel on
>>   the same file by the server.  Therefore, a copy offload stateid =
with
>>   a seqid of zero MUST be considered invalid.
>>=20
>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index d7f27ed6b794..33ee1a6961e3 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -793,6 +793,7 @@ struct nfs4_cpntf_state =
*nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
>> 	refcount_set(&cps->cp_stateid.sc_count, 1);
>> 	if (!nfs4_init_cp_state(nn, &cps->cp_stateid, =
NFS4_COPYNOTIFY_STID))
>> 		goto out_free;
>> +	cps->cp_stateid.stid.si_generation =3D 1;
>=20
> This affects the stateid returned by COPY_NOTIFY, but not the one
> returned by COPY.  I think we wan to add this to nfs4_init_cp_state()
> and cover both.

Since time is creeping on towards the next merge window, I assume
this particular fix needs to go there, but I don't see the final
version of it (with Bruce's suggested fix) on the list. Did I miss
it?


>> 	spin_lock(&nn->s2s_cp_lock);
>> 	list_add(&cps->cp_list, &p_stid->sc_cp_list);
>> 	spin_unlock(&nn->s2s_cp_lock);
>> --=20
>> 2.9.5

--
Chuck Lever
chucklever@gmail.com



