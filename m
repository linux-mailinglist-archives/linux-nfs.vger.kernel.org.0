Return-Path: <linux-nfs+bounces-17277-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F051CD828F
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 06:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8015A301E92E
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 05:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AA42E6CA8;
	Tue, 23 Dec 2025 05:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRS6qc7F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22552EDD40
	for <linux-nfs@vger.kernel.org>; Tue, 23 Dec 2025 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766467988; cv=none; b=Q3QsxuA1ACIoN8snt4Gz0xNfB+pCHzcILiPTUT7oaekSKC7Moga0uxybIs1mkG7s2NwY0ru/cno1pSLSE57H/QAOIZe4GHuUV+uN3QJOVWD0F7GPEpcKuXx1Ah6Mp1AuNJaUyiWPzevOKx5k1y4Va6ix24wphfv1IrZ4PIiocJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766467988; c=relaxed/simple;
	bh=NqkuKEROb/OmRVYRZgeOKw/Kls8Un9PKgqEiKcwkGnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAtkIP0l8dZoRjDcwluDTBZUg7UmJ//Y9OUWj8sKddt+gIlnRrK+HPEJIMwR3XqU2pZDjDXZrAwXX0m3KcjvfkjEv7CI81ZkfedGlMEBCAeHhdXHw5EKtFGSYOaW+L8CK2HQ6466ZKGKl3QAbAeOfUETM2VFU4cAUAF3eRYDA/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRS6qc7F; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso2635025a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 21:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766467986; x=1767072786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqkuKEROb/OmRVYRZgeOKw/Kls8Un9PKgqEiKcwkGnk=;
        b=YRS6qc7FN4EtduWa68ZXt023TSQiTMXdK7qVlD+eqY53wkWAc89L+baCoLPtatoQNV
         nRV1kqExU4x0Kq/7nLf23qk+jbHPJl1ohW+d6khZJaUUSHKu7UEyHFcuAq3mVyZfVs2E
         mTs3xHvhMuxCjBsNRAzGXzVyQIm1hFrGsZkIVSNA3tnwpvXfk5MxMCrp1htANa4luD++
         f1I0ejIHnRULvDlp6uuawM2q3dtIwL6o3ClXqX/3lAzNiyqtoHm6/1AckOVeDCqzznAA
         cvLnp8ljOlrbS/ahjo6lewbqz/tmL6Gf/oJ28nvKtLYo97aUsLsSQU7wgUM6LnBxyHtH
         UOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766467986; x=1767072786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqkuKEROb/OmRVYRZgeOKw/Kls8Un9PKgqEiKcwkGnk=;
        b=RWk6RQ560U/LKf2JSV2Q4AeuxKRsThqEqod+DDaNnOYeQx4YvB6pjYE/M4zFpjW07h
         d2UPHs3r0SD5SeSkTqGfd5dd9mOwF0a17C0V2zEjY4kw/IAfGXF4L+3bbGaocymsjYFp
         CyHDSvGEIS+K7ZwOabENxy44wpMSQyprwcggUA4mVkDJS8gptq+qdhiRXtcwx3Vq4vbg
         Ovy/zrtskDUKMzsEsUqiqKLMOVHeuatlMdkQ1wUwT4tnm8BEWnEvHiTrCJiXElkO8jE1
         hVUtT5Nl054L0G/bwOjcdcwIt7ZdipvQclkL4lbFlYVRXjhHcOm1NOpTYdY1hzs6EiFc
         Vwpg==
X-Forwarded-Encrypted: i=1; AJvYcCUDIiG6FOHchspZnNONJFvPWw/JeCTDXtshBq9H9zg5ZbqAjOogGXcTfPYClqDEvJgokSFirs5BBpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT2wmaSk2Bii8vDmvaT7f5juX0UPYr7h1ix3zb030SDtRPigHO
	OrdQUUld2Bl/sTxThUzt88Viv/AQWFGgSmuQaQ90CpYmSDjbD3jWTyYurqOxzKjj
X-Gm-Gg: AY/fxX68nP6CNAOriiHwR7bhH5QQpiN8lEIHRSI2jffgOowUg2SGxP5BEVrrQm6P33W
	EgchIAF4DHiV+GIliyDf62p3SY9TCcPFpE+I2opMmy0QJrI6Hzcu7BwB7J2Y2ItaTAR5lT24x1P
	VhHzXl+yHmW3f4XFvWz8hiAqnpOq1TO47l3c/dB8rK8wQiLD05TWnC2fZIlZWWk56eBWUReoZmC
	gGjgZ+sokD0fOG6cYNMyTiTlQ5q4uqhL6ROwUS8vmXNSKAMAwNAi/VEv5l6S/o8DcOWzftpfowa
	8zntsP+Yz8ksTRpnLLkWPagi2De+gkQ+etqcsHocegAY1lPdhjOb7oc9svID1wlojWWJpFRJd2s
	lcZ7J6V3JQvnCfbXguJ5Cjkinm9gqS0YAfpm68d+sycQes63ib6OzcOO8tQVdTLLQaa7C8Bj71t
	EQoalMyzHRy7p7DqzucEtao4sXEVl2yE4LwqjHcBpGU6/nswGcIPsgBstWNNzTKgQq
X-Google-Smtp-Source: AGHT+IG5Qf4dCPxqVYyhhZiZ2cPZHWZcc5Jl8Dom3Sf+VbFYEbzUaslYB9RlXBdrrGXOm7O8E9bw2A==
X-Received: by 2002:a05:7301:1a12:b0:2a4:3593:ddd6 with SMTP id 5a478bee46e88-2b05ebb6038mr11158060eec.3.1766467986000;
        Mon, 22 Dec 2025 21:33:06 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm54002618c88.0.2025.12.22.21.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:33:05 -0800 (PST)
Message-ID: <12bb96b6-1e2e-4f53-b4ea-1fae2500aa21@gmail.com>
Date: Mon, 22 Dec 2025 21:33:04 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] fs: exit early in generic_update_time when there is
 no work
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Carlos Maiolino <cem@kernel.org>,
 Stefan Roesch <shr@fb.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 io-uring@vger.kernel.org, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251223003756.409543-1-hch@lst.de>
 <20251223003756.409543-4-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Exit early if no attributes are to be updated, to avoid a spurious call
> to __mark_inode_dirty which can turn into a fairly expensive no-op due to
> the extra checks and locking.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jan Kara<jack@suse.cz>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>


Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



