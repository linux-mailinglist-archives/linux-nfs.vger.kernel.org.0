Return-Path: <linux-nfs+bounces-18954-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xVJWEZjyk2n+9wEAu9opvQ
	(envelope-from <linux-nfs+bounces-18954-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 05:46:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1D2148B97
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 05:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F32F13013D71
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 04:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42022153EA;
	Tue, 17 Feb 2026 04:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmL61kHQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953F71DF271
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 04:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771303572; cv=pass; b=i6dexqRK6JJ+GnIzJEeKm5HWAl0ATuH+Q5rQ+5J6h8eegtQA0547bkOsawrtbAhPmnX8PCMARmTfb0OZwOQDRSKGW01ded0qA0+WSNZL/JHEXir+AA2Q00RHytxrfo6EWc1yK2t1MPpANileKRPFgGTgC/RxrkOA89wSOkXM4zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771303572; c=relaxed/simple;
	bh=nKGvllvCG75fwMdLnJD7PMiU4Ur/hq+HZsbw0YKAafk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nnJLEKs5FaMU0RWPhH7URJuD00iXH5vmmLaLE33YFfzh0F5YIGmpmRAmXIjDSk5FY8B/5RikAhX5NDbkacLn/BH+Vmt8vikTTxgCNPV34RDOZwCHZqzfhs2pWLLAPDfAhWJscaPtl5JYTO81P0d/1GMZWY+biqnie1he0Xt1Xvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmL61kHQ; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65a36583ef9so6438136a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 16 Feb 2026 20:46:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771303570; cv=none;
        d=google.com; s=arc-20240605;
        b=KyYPOPFSTWnvRLcR+MmLmmKd1uUAz5HcmbxYvxzlmE7jytk1on5bIkuVU84GvETvIi
         pyWyV75Kx5UVawbIC/hSWwN77BDt5pNjIGdp60lQxaSndB5MJ24c2k2wxdEHCjOxlrIE
         RguEL2wpxiylYrmWk5rsUsQ7U5g7nBmomVjX4B+EX3i157wK9M9qrGRqm5PZ+wFT3I9y
         H/N0ocSJppUt082osF7ZGOqIA/JDLX4Ssrd8PWi710ZNb4ifBnmRGkVQNgwfKhIHBz9w
         s5iIK80jDkV+QGQ5e6DqSFFiFYcLRs3BtDMd78DpeRnQk8l6k984t2fUsP1VpJUsvcsK
         CMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xmAbP1npaRP/EktzRfWlFJfADINwj1eoIm5/zjg+zdA=;
        fh=wRiIL5sPCMM3SBgdS42bapEcaLi9fWzU8xUBo5gOSFs=;
        b=LWsC5RsRzUdPfQkFq3eTTqbT+s+lZhprZGPuqzH+Q4Ww7MWpvIkv+R3WSbTZBQXrfV
         TKa/zTsLFAx3gpLWpO/oja54DdSFnCEkuPkRVRQpR/XpAu7NeqHZwtWoAKiiAnTmlQkx
         7F44N63/QSzEcr4Jx7DMD+QcYG6U9I42hMEwM1DQm7P6jYlYb0lvBt+vErEXh8PC1Pr9
         zZ68Zc8wGo5VQK5PNeMYTloi0q+tVftA25iBn+McCyOODLOoMuVmQilwOKGhg2Jif7wW
         WUsjl86QifolqGVsxs04U86QMhHOI3P/yT4SfQ9BmTldYZCegWRN2/Q8FFd6tMpyxa4Q
         DUcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771303570; x=1771908370; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xmAbP1npaRP/EktzRfWlFJfADINwj1eoIm5/zjg+zdA=;
        b=HmL61kHQ48KFTO1gsVXarVuiJNXp50WTfuB63Okct4sieIhJfriayZIVlmYOu1xVwW
         MDKhesC6dJ09fcmTla5KrSOj+RwWWP9TMVjSaqx6suXMPohnE6SUR1QLbJV61uzvj80O
         It0mp8L5Wpdn3tFodQZX+1URJcOCtgJxx8Ig3cv5E8P2gUJ1dZ7shE0VsyH8ZyyXnQi8
         qpreqeBufuzZbVdbP6DFXvdY6fzphWloXRDgngtJr7MdGeALb8IsJr6611/PwlcFbmI3
         atBCDWPqoxR0ktyP32f4SRjGT3voDrqyghUijtWySbjsivmu6u9RcPZctpZS345FEoFh
         Ffsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771303570; x=1771908370;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmAbP1npaRP/EktzRfWlFJfADINwj1eoIm5/zjg+zdA=;
        b=rG0Y5fP6Q2hTT+yBGXc4Fn2Gnpz+rqgSFkOk+8TrvbMv5gcp2MU+q2ta7TdzrfUuoa
         gfA+XlVFij1FM+QjHqrRVeKGDEWOWATOYvE4Noqn4lTz7hf3Zj6uUVUH6yF3GAMo5o9/
         Vwv1QlvNhnI3FvancPbmeOafy7B+oGefmCrGXGmHAVp37uN8jT74zQTh5akR+RdJBol9
         2h4maCaCu7SAogKIZ+EA3gVamSrm6ADT/zSripz+vkNjuOmiDlI+b3Bb+csztgAdx4hH
         NYwEHSx9Ltqa4GhAeoYXj/PLLp+6+HyM2kUk2HueATtq/C+lxwlSf8SGr0SptQDHMLgM
         QosQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoBqqIZUyoh5Q7a6bWTVD1ejo2BKu3P/4scugeUvQ54/3XC8sEjMGDOfaadKaIj59DotE3hkoG0WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR3xNhDC7H5Kmcphvtpk4rms9yb/fuUhf2ebS6ue+EYY4j6kVv
	E+sbgyYmYVJMepdVoVaeOWl2v/5AqnoTxrhif5PnOiZYUESASsjnfLXn/XTWfh9cKiSdG+KPiQX
	27l+f8FAWNUOJcbthJXJrlDstzdtcGUlfHbxF
X-Gm-Gg: AZuq6aJtS1bXxgeDtB3/+bSvXxfEZXJBVxVzYS+gNTiw34Ye56yGtj0zdzWZMZtdDD1
	lQPapW3UovJCsQLLPzOmCybaTDXs9dOoApQlXYT2L3UXnDri7yQNdLKViAZwXu58Eew/whl0EGl
	5C8Bv8Yx3N87UaDR/RX0YlMv+05x7oxIlAWGiA3xcRl1vF3VJrU7XsyYjYKbd6JYUXVKJUAtQms
	od0lYoVo/ZOfhHpByM96EnO+tZIcmUYhyNzIwMLdBmUkoJVHYJ8NKQd2kMq5Gg47UHrM2qOY7Ib
	w3sX3g==
X-Received: by 2002:a05:6402:3554:b0:659:31af:b9af with SMTP id
 4fb4d7f45d1cf-65bc41dc297mr5553172a12.0.1771303569746; Mon, 16 Feb 2026
 20:46:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 17 Feb 2026 10:15:58 +0530
X-Gm-Features: AaiRm50t13k44Sen9NRCY3Mfw1UqRelWB9C2dA3RFTYoLt5Y4mPqd0YjIZDY934
Message-ID: <CANT5p=orpQdzqxjNronnnKUo5HFGjuVwkwpjiGHQRmwh8es0Pw@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Support to split superblocks during remount
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	linux-nfs@vger.kernel.org, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18954-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8A1D2148B97
X-Rspamd-Action: no action

Filesystems today use sget/sget_fc at the time of mount to share
superblocks when possible to reuse resources. Often the reuse of
superblocks is a function of the mount options supplied. At the time
of umount, VFS handles the cleaning up of the superblock and only
notifies the filesystem when the last of those references is dropped.

Some mount options could change during remount, and remount is
associated with a mount point and not the superblock it uses. Ideally,
during remount, the mount API needs to provide the filesystem an
option to call sget to get a new superblock (that can also be shared)
and do a put_super on the old superblock.

I do realize that there are challenges here about how to transparently
failover resources (files, inodes, dentries etc) to the new
superblock. I would still like to understand if this is an idea worth
pursuing?

-- 
Regards,
Shyam

