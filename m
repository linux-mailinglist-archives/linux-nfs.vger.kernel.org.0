Return-Path: <linux-nfs+bounces-22029-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI55NhtHF2qS/QcAu9opvQ
	(envelope-from <linux-nfs+bounces-22029-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 21:33:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C65E98AD
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 21:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4341C3001491
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 19:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DA737B014;
	Wed, 27 May 2026 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbE7DMrm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7GsMYXk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D8037AA6F
	for <linux-nfs@vger.kernel.org>; Wed, 27 May 2026 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910269; cv=none; b=CbdJR1273rxX1LxwR00MvTlSfyKxVwCeQi546MBVd9A0dDZsY8pCfE7iTxniwPapJ4A62BYJSEYokedWLsmfEORaEFBeQU+2kX/57pYLiZbF1fDKNKW1HgBTrM0tbAfsUpGNDlU7emdU826u3hR0kOpBURItINZwf2efV8seoJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910269; c=relaxed/simple;
	bh=yrX3vvjjHO/PC3/HPk9swbVTaTVwsdia6lBWdQjC9lc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ikYLHB6ePAdk4Muqjbrpc98/Xd8EVPhR5G3FqVfUm/zm/AvKe+PauyjHvptx5UM436jxATVRkjd0YaZYic23Xprm49sWWD7hiIRieekj77QzrKeYegnOriSXe3kHqOi3eMxJlE4XDnh36GVGHTJXc2ZrqfXtCsvDuEjXGQd7eRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VbE7DMrm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B7GsMYXk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779910267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=93SDyrJ+jkC4rzGXhoTkMREsS6cYtpqsG59T/GCV9o8=;
	b=VbE7DMrmyE/6zr1kes71NAU3kAIVH90WpO5pXoTpZ1Wpsz7uGcCXQfhgGAjhFoNoRjzBwr
	VBM26waWt14lTXJONqNVyRTu6WGf9CHSaBY2cIudCxLkXOPKfGO0LJoIwluKSQfGx5eEGk
	fjUOB1rjS3CC0k7Vxs4vKLvhvgGNxSo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-XBuJC4nuPRWFz6mX4o8Wgg-1; Wed, 27 May 2026 15:31:05 -0400
X-MC-Unique: XBuJC4nuPRWFz6mX4o8Wgg-1
X-Mimecast-MFC-AGG-ID: XBuJC4nuPRWFz6mX4o8Wgg_1779910265
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-914be3ed6caso399412285a.1
        for <linux-nfs@vger.kernel.org>; Wed, 27 May 2026 12:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779910265; x=1780515065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93SDyrJ+jkC4rzGXhoTkMREsS6cYtpqsG59T/GCV9o8=;
        b=B7GsMYXkJNcEw/jUWsbC660VcDEoJJi50tnKb8i43lFK56JHz2El8Q9b6T0Day8VAE
         Lp+rkOlGQmgG4rCW1I83rCvGCSXKfd1JOnHGMU5vLzxyiExNJef8/J17ZVoEzG+ZxwL1
         8NM2fw4/KfvD7wl7VzRz1CNY+GdvR/dZ7q+Mt4/tfWYL4pbBsYMcmfl9TV5Yc2hkGqi3
         unOP8Goc96oRtdtctd5TgNlTxgVoLr6ist4byLKnWU2vG6VVd4DAbL9IkIDdSgPjvK04
         AX733rb7qpKmnwyVMsGnn2LwUKYLYterBOGZx7PwSJMjm17nvIXBvgkm3JhBTuFGJVAP
         v3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779910265; x=1780515065;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=93SDyrJ+jkC4rzGXhoTkMREsS6cYtpqsG59T/GCV9o8=;
        b=lSIvIswCG14hq7spDJrZLGv/pc6WcAypS6I3jsyGEncOpPiNZq6AfmeyrBN/vYWLF1
         yLkeF5EyOuysZePK9PoeTVPcEuUuAhq9pP3eKJvHec9dAtvufN4cJjdmOqsOGdEWBlIN
         0BWJpsozXrFbUsZepefZcCdNvV8lBeXCmvC/U8y1WOBo5F0/MpkaXyzsSl0UPUnnEgQP
         roAEnS1d3qACJgDuPRUo/UNgGooKiNSBk4nnJA1lKeHrFMzO8JYwzUb4ho9Qnaum6SWW
         ffAEv4zPBuy7oY+tgHg9edF8adgOZkdFeChiZ2q9hm3yUaW8mws1nQ6ty8Tb8ZeVbmfV
         ljGA==
X-Gm-Message-State: AOJu0YxTrT8ph6RJV2JK6E2QutekDibzVPKlAdirQBJyiSShJKl9jvtQ
	edcKeFwUXgQYCIdBOzkwjhu3NBxjdV3NwigExqvGu4+iL+mOYjYTb8rBsE1vGM/ajoqrQIlqKgG
	AjDFhupJ4Tvnk/qyRe1ku0C3PN55iNvj4AWxe3XBk/mRbQH/KJVQwyMWFjovpT5bwDBgW/g==
X-Gm-Gg: Acq92OGybIS1teUGevQvqNJhc3o0vVSLeAHjurmWTFbRQTysNGE4GZBi6asvCltpsi2
	z56T5iq9TVH12K5fUrMQLetHXdxntiBNyycaGZC45PYA1RqlS5+akBI23ng5Ca0XTQ1LZw6WF//
	26cxEoJu3u4IxYwDoO+1rDYPyuhgI2SxIJAiT9YdVrzBVmxVnX6uWPZ165rYXDJ93MILOonGHvZ
	zQ0uCQzj8pHuHEzQg0GEv3stf9ldSTP6pGsFcdAsEyAfeZboP1dum8fKo+VR0etLZGi68Z/cpZv
	QXpDUcdEgIQ56soHn5gzgJMBWJcZ3fJbHFHBP3NnuG7gNPBz7PEbLGi4UpI6ypL9x2+d2Pkoogu
	vEkVgXyZwcNPCZmITy80Lh6vXrtq0+T7v
X-Received: by 2002:a05:620a:f0b:b0:914:7e9a:2711 with SMTP id af79cd13be357-914b49a289fmr3504737285a.45.1779910265225;
        Wed, 27 May 2026 12:31:05 -0700 (PDT)
X-Received: by 2002:a05:620a:f0b:b0:914:7e9a:2711 with SMTP id af79cd13be357-914b49a289fmr3504731285a.45.1779910264566;
        Wed, 27 May 2026 12:31:04 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.241.172])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87d26basm566817485a.24.2026.05.27.12.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 12:31:03 -0700 (PDT)
Message-ID: <5cad3ab4-d24a-45fa-b1e9-d57b2c47a5e4@redhat.com>
Date: Wed, 27 May 2026 15:31:03 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: rpcbind-1.2.9 released.
To: libtirpc <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22029-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 355C65E98AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This release contains:
     - A number of memory leaks fixes.
     - A couple buffer overflow fixes.

Thanks to Scott Mayhew <smayhew@redhat.com> for doing
the majority of the work.

Both the tarball and change log can be found at
   http://sourceforge.net/projects/rpcbind

The git tree was moved to:
    git://linux-nfs.org/~steved/rpcbind.git

Please send comments/bugs to linux-nfs@vger.kernel.org and/or
libtirpc-devel@lists.sourceforge.net

steved.


