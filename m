Return-Path: <linux-nfs+bounces-3314-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EE28CB0E7
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 16:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0551A1F219B9
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5487142919;
	Tue, 21 May 2024 14:59:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FE77EEED
	for <linux-nfs@vger.kernel.org>; Tue, 21 May 2024 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303563; cv=none; b=TokrNS5wBrT8vWfimnn+ld/0IZdnZvy+IPocQRUBIXUWHN2pIi/OGM2QRqwUw6rLhz9JCSoxYSW6qmxfAFELK1NNRdNrlNy/ZhdSFmWH0mRQA9RHvcdwQwhLqHJvoFcZ0kBmlkujVljUOFb2bdu5/oxnMRnz4YidFsYWW+6sxCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303563; c=relaxed/simple;
	bh=SpXWK815x5LFJVFdv+byuY3BoxS+nQ6l0iC4spt6UbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3WsUrcJa3lb2TTEDHgoozGjzQTqV6o32bHKR/Qqel+C9taEi+yCrqzX3E0mrcMqdpZeg31R+9X12QJKOLLjs6YYWAXx439zkqqgZAeBOR9uNejBD54UkbivxILjnuo4YgouQpt1awe9JVDDApHABzALo09vlThuw0EhoKr6rDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-420197fba0eso4402045e9.1
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2024 07:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716303560; x=1716908360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpXWK815x5LFJVFdv+byuY3BoxS+nQ6l0iC4spt6UbY=;
        b=veG/Le/ZUJDu5bcsnMzyCCUcB8axBv4NUTSijP6qE5Osjnzwr5DYIU1zEXpgzhC/ND
         SV6JC7A3oLVabEyi44UkXOorjYO5fNN1A9i9MlUJbo7nvcq/aqoXAfZxlm9Ud6etGnbm
         bmdett3jBZ/zgetjDGYkIOn8RHPQN1QQ8bL3+KE9jtPIMF2ITVuGCaMUmVdkaazIVdnW
         v0EAtsur8e8PM/giOx4CcSZfsMiSWaC+HCsqChEOk3AGRP746b9X9jTo7M4NccvqKW3b
         mMpX7u5jg4p1rkgusD2C8fWa4LPJsNtz1Mrd7fP0dqmqs0nJrkyLEHzy5O5c9CCABBcE
         d74w==
X-Gm-Message-State: AOJu0Yxs4UEK4NBVgE9++VE3ac1ayl7Q85H4jUqBdRA9oeVW8QUtI1wn
	Ri+WyX99eHB37Gvh6QZvpffo1Rn7uyyIOeD+WkiZEIEC8muEUCm7bN/W2w==
X-Google-Smtp-Source: AGHT+IEXttZE1WFUyHALKKpUlgx1G4ZWyirBzA6jN7EOB6auIMXhzoTITzVfPUic4EtjFXJ/4pgGSQ==
X-Received: by 2002:a05:600c:3b0a:b0:41a:3150:cc83 with SMTP id 5b1f17b1804b1-41feac59d8emr237697505e9.2.1716303559984;
        Tue, 21 May 2024 07:59:19 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87d20488sm501285185e9.25.2024.05.21.07.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 07:59:19 -0700 (PDT)
Message-ID: <c43d096d-bde0-4168-931f-0df96d8b0bed@grimberg.me>
Date: Tue, 21 May 2024 17:59:18 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Dan Aloni <dan.aloni@vastdata.com>, Christoph Hellwig <hch@lst.de>
References: <20240521125840.186618-1-sagi@grimberg.me>
 <ZkypknHeBtBYJetq@tissot.1015granger.net>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZkypknHeBtBYJetq@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21/05/2024 17:02, Chuck Lever wrote:
> On Tue, May 21, 2024 at 03:58:40PM +0300, Sagi Grimberg wrote:
>> There is an inherent race where a symlink file may have been overriden
> Nit: Do you mean "overwritten" ?

Yes.

>
>
>> (by a different client) between lookup and readlink, resulting in a
>> spurious EIO error returned to userspace. Fix this by propagating back
>> ESTALE errors such that the vfs will retry the lookup/get_link (similar
>> to nfs4_file_open) at least once.
>>
>> Cc: Dan Aloni <dan.aloni@vastdata.com>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>> Note that with this change the vfs should retry once for
>> ESTALE errors. However with an artificial reproducer of high
>> frequency symlink overrides, nothing prevents the retry to
> Nit: "overwrites" ?

Yes.

>
>
>> also encounter ESTALE, propagating the error back to userspace.
>> The man pages for openat/readlinkat do not list an ESTALE errno.
> Speaking only as a community member, I consider that an undesirable
> behavior regression. IMO it's a bug for a system call to return an
> errno that isn't documented. That's likely why this logic has worked
> this way for forever.

Well, if this is an issue, it would be paired with a vfs change that
checks for the error-code of the retry and convert it back.
Something like:
--
diff --git a/fs/namei.c b/fs/namei.c
index ceb9ddf8dfdd..9a06408bb52f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3812,6 +3812,8 @@ static struct file *path_openat(struct nameidata *nd,
                 else
                         error = -ESTALE;
         }
+       if (error == -ESTALE && (flags & LOOKUP_REVAL))
+               error = -EIO;
         return ERR_PTR(error);
  }
--

But we'd need to check with Al for this type of a  change...

>
>
>> An alternative attempt (implemented by Dan) was a local retry loop
>> in nfs_get_link(), if this is an applicable approach, Dan can
>> share his patch instead.
> I'm not entirely convinced by your patch description that returning
> an EIO on occasion is a problem. Is it reasonable for the app to
> expect that readlinkat() will /never/ fail?

Maybe not never, but its fairly easy to encounter, and it was definitely
observed in the wild.

>
> Making symlink semantics more atomic on NFS mounts is probably a
> good goal. But IMO the proposed change by itself isn't going to get
> you that with high reliability and few or no undesirable side
> effects.

What undesirable effects?

>
> Note that NFS client-side patches should be sent To: Trond, Anna,
> and Cc: linux-nfs@ . Trond and Anna need to weigh in on this.

Yes, it was sent to linux-nfs so I expect Trond and Anna to see it, you
and Jeff were CC'd because we briefly discussed about this last week at
LSFMM.

