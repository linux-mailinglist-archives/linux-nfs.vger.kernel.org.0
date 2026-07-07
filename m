Return-Path: <linux-nfs+bounces-23134-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qbLqBzv5TGp5swEAu9opvQ
	(envelope-from <linux-nfs+bounces-23134-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 15:03:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A01C771BA82
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 15:03:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=H+pBLVSz;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23134-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23134-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19383300ACA5
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 13:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D007194C96;
	Tue,  7 Jul 2026 13:03:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE55724B28
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 13:03:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429431; cv=none; b=TpArz/MHDNeiwNWudBXhmbyktbjwUj+Re5cz6TdXQXV0fWdquMlW4Mqlhwda132084kpcezuX1iiMPx59rTF1OWmhDbZCTmZJYkPrJZHt1X5B3v8GH/TE+V7S8qtZpKVZl5wTlln62WYj5R5dwuBBWli+9OPnnfnzOeKpgqr908=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429431; c=relaxed/simple;
	bh=NNfQQm3zNRiLlPrip7eYqxGOQ16vT+qI/fCJGyR12tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UISv4skoRedQq2Dkqk9Und4lxXdqxWteY0fcal1JZON3orgUZc+R2ExiuK8fOGpbqs/6v9SLGvNwo+LeXa4PP6uxKt9wyHpjPoxzQyvQ+UHwhzkLflR+olk6Mjdl5OHmB5HSTIVcbpNB5G2OpHJiIQPyZIovTnLM1A2cn1dcae0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+pBLVSz; arc=none smtp.client-ip=209.85.222.45
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9692373e0b1so998700241.3
        for <linux-nfs@vger.kernel.org>; Tue, 07 Jul 2026 06:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783429429; x=1784034229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nXfj7bIm5ZFLIX80C2ceDWe0k6mggys49zkq2M3a0ls=;
        b=H+pBLVSzaGoZqNbSDNCDY3+G6sMNMruLo0k1ZAUDmuWqmL56v6kXnIJltHUk0d4e6f
         h4sElY2kcZ/yqhexYd+pIhcBrS+nMOod3xq2ObHP+dZ38kGqkMM4vi+ITdpcup0twcZE
         yF2ToOv6bNNu0Ugx2IKmoJzs20j4sL0m2qzav8MuhbJ6u5STGubxyRCkXECLviLLG6Gy
         ogiKoxX9U/YlRBMODHfTQhPMnzIvEmata9cH/nQh6m2rTFcSnLq9lQRcgNG6ynMbH8qC
         O+QFcW514Mtkx/U5JNNILci/unavszT83b2c+LHgOk7Oov5XMrhTnqSSRXrG/rU04I0t
         m13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429429; x=1784034229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nXfj7bIm5ZFLIX80C2ceDWe0k6mggys49zkq2M3a0ls=;
        b=VAxJrxi6xIdQPnfObe54g6OqsQDZ5TlfaywN81LXIkk9l9fuj69q77f/0fEgU+lD/l
         qMaYSI4iRyI2RfwBMLcOvwxt3qV3djsaFv/WzL1zBNLDHf8IcprFarIon0Skm1fE4sMY
         NotXtJ3fZ4cJrS0xRJ/56nnRgbRV0wERLqe2hfgCqO3bz9L5ha/xRCOZbRDJQuAzFFOS
         BGIqZanQnzpcpCesKXlCnL14mzyhQEbXkldUMc1ZJW8QuU0e+2HgyempMkXjDZ+zaN/j
         RYzq3ZC6Q6QVn+m4gPLkzXeBEin+p0vICs7BFFfdLOaXiyrhbzjqvNQ9MKMpAb68F3DY
         tPWQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqmf3raVRBNLOlbuQuF4TBD1BwCvsYp8ik395ZkuT9TvC5I8TIOp00T3FxJqBJ1dp89Q0/RmwgpsX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNQi7HfFYGVzKr0u0cHnoLiF+YEhKHESlBbE9k/cZH0HmX5UNS
	qNH7ZkGPIpVWGLL9aFHEFGJaFA4S9HyUkIPi7w0Qa1JM4YMgTxQiPICB
X-Gm-Gg: AfdE7clT3M2AzzP8v9nobP7mM+3AbjsFk8G5V9R6FJXZFk3TaTenT1BCyzkdlbMug3d
	RPs7yQL7NstHHgRIdjsWIEYVIUPtw6Pyi4z3ULCQTqpprUX9SrDDKsYtChACGdRXSq3hUKOY8Ex
	qBTeUHT6eMQ1riA+A+mfWlNos/lcFasoyKq3br6epMmzrPD3Igqt9BybahEpPsS9Xkskr/dJtzM
	74HkDQIk8tkuA7E5XBLnvheLS3MOt29HN2ZsYvRdwfLY9tHXGiLRyoa6beGFv4W+MCw0WF75H5a
	A+i5vaSIvWvJprVC+lSTq//Phm9/3uxI2eHp1moOwwkBw34fE8Mjhae5CFkihn2uDVXDyrCefCk
	cNCnFRp6nUXf9cIHKrDHEAUS7PXzhRGevJNd87Trpobj9lSynlJYvrWrhD23ZjOV5c43l+kd4zA
	l+Jpjl/uR46rJpQhpseP/vaIyjAcrAbcsMSMeyPwtV+tIvRU84vXiQrigCTL2WQUk+LTgx/94=
X-Received: by 2002:a05:6102:5ccc:b0:631:4cd8:b6aa with SMTP id ada2fe7eead31-744b7bb690amr2858442137.13.1783429429415;
        Tue, 07 Jul 2026 06:03:49 -0700 (PDT)
Received: from mainer (pool-71-174-70-84.bstnma.fios.verizon.net. [71.174.70.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724bad04sm172622126d6.44.2026.07.07.06.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:03:49 -0700 (PDT)
From: Achilles Gaikwad <achillesgaikwad@gmail.com>
To: paul@paul-moore.com
Cc: trondmy@kernel.org,
	anna@kernel.org,
	stephen.smalley.work@gmail.com,
	linux-nfs@vger.kernel.org,
	achillesgaikwad@gmail.com
Subject: Re: [PATCH] NFSv4.2: fix nfs4_listxattr NULL pointer dereference
Date: Tue,  7 Jul 2026 09:03:47 -0400
Message-ID: <20260707130347.5857-1-achillesgaikwad@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAHC9VhS3_NCZm_GmF-nxPxJ_EPCsScEa+=y8vBqqneq-M00=uA@mail.gmail.com>
References: <CAHC9VhS3_NCZm_GmF-nxPxJ_EPCsScEa+=y8vBqqneq-M00=uA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23134-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:trondmy@kernel.org,m:anna@kernel.org,m:stephen.smalley.work@gmail.com,m:linux-nfs@vger.kernel.org,m:achillesgaikwad@gmail.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[achillesgaikwad@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achillesgaikwad@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A01C771BA82

On Mon, Jul 6, 2026 at 5:55 PM Paul Moore <paul@paul-moore.com> wrote:
>[...]

> I wonder if it would be better associate the handling code with the
> security_inode_listsecurity() call a bit more closely?  Thinking about
> it quickly, would something like what's below work?
>
>   left2 = left;
>   error2 = security_inode_listsecurity(..., &list, &left2);
>   if (error2 < 0)
>     return error2;
>   error2 = left - left2;
>   if (list)
>     left -= error2;

Yes, that works and is better than what I was proposing.
strace on my nfs mount:

    listxattr("/mnt/abc.txt", NULL, 0) = 26 <-- v1 patch, actual is 42
    listxattr("/mnt/abc.txt", NULL, 0) = 42 <-- with your changes

Tested your suggestion on v4.2 w/ an NFSv4 ACL, an SELinux label and a
user xattr present; both the size query and the exact-size read now
return 42.

Will send a v2 soon, thanks!

-Achilles

