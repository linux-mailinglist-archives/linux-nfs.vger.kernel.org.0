Return-Path: <linux-nfs+bounces-12947-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA19AFD5F1
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 20:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216063BB173
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 18:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C210F21B9F1;
	Tue,  8 Jul 2025 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MX8SgYnI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85D721B9C6
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997922; cv=none; b=DNTPBpcP9yqk7A/bB0ZhEASUTdYUKgKyGKYdcTw7NFbM2YVBNAjAH/caB8WPjLlS46oKNboZQp62s1ygBLDpeCkzKAddhuD5fffizEkROM1TBiwD6NZhcj7wc9ac4HeBagTeqFNDJKJ4mkRvQFEMBEWvjUIirfijPgDSVYqMbRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997922; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=nlNsXcy90q7vKVmj5tChDlS1WATNJzgPkmCuMggKnx5Oc/SfRIdbVXYVnYtrmdiupyTyI/1I3veCB5zPm8u7DCxh8wJ7TbuCWNbMWI0P7vS7nrVqqb2qB2TVxuZ7Mlhx05SeUg66O1WMyxbmEYzCwpPvqTm8bw8lh3k7nApkPHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MX8SgYnI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751997919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	b=MX8SgYnI82KBirWX4YRNpxwrmC6yag+auR2QSsAyN82opmcUj0zydHpvb64wTif82BrnwK
	l7TfIp4LMz1fmf0dzPD0Zpwv/y/qW8KQf65zikDNKupzKd4Rd171VSAAzEPDursP5v2oeD
	09eRe2HseKteLvSC+7XRaxWVnB3E2d0=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-SEKHW0N7NsCRhKqfnqouyQ-1; Tue, 08 Jul 2025 14:05:18 -0400
X-MC-Unique: SEKHW0N7NsCRhKqfnqouyQ-1
X-Mimecast-MFC-AGG-ID: SEKHW0N7NsCRhKqfnqouyQ_1751997918
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-2eae95dfae3so5367412fac.1
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jul 2025 11:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997916; x=1752602716;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=odpoq4uiDIKyL23HgRJukH7GkNYLHTADmcyDCAQM2leWv+/rxKvQEb9quf+8SY0NnS
         WYQk5n+X3FdtOTikr4FiFDERUEZ3Z8EYy+9aMnkmzPcNx+sKu6ByJAlnEH4/H/VyB/zI
         X+BVuk2rVLfId4joiuTfB/vcFkr2MFS4nSw9+N7+1ZtE/dz+0EApxFr3TqNX5EA2QCBv
         75a9mYVqx869If9vp9tH+m56udiMojXV986Jn2odbiUmSuN5etJvnN38Lw3SgGkwFFkd
         NBaka/m10XP8xOe0on0C9K9h1G1zk7L1ZyWLdZ1TpJwhZfkBTc3f3BKAXkY9HUZVojAx
         Yx1g==
X-Gm-Message-State: AOJu0Ywe1xJjaT45u/LnOdGYfFkogJzRstRVA+JuLQNn6P35BwxpI8ni
	qCuMCHdrU/K1+gLfrZrWHaogO/BC/XKP0By0AhR72BUqw6i/jj1iu5KGRA2JHjIPOyv3RC7kDeW
	BW8gumDknBn41ybo1O/cyIb39NirrNHaFrAYqa56XpzAOD+wDCFNC3nbKPCc0El93fTqRWw59il
	cNSFBKjO5d8YKPNueJjVSsyuRtBlF1yAhjQeXA5FKXjA0JJw==
X-Gm-Gg: ASbGncuQTlUgU7943w9N81xGPmI+NTUEtR3oCaJs1kVqTcttnsMci+vbkkqVyV2G0Z5
	8GA3kf40duFdw6dp7n6frBmlqSZMKBeL+tiJHoPoXw/G2Qp8hkXuJ97qV9hlrpYIaD0ivkwPxKC
	Qx5LJIp8KNYwRTlBfUvV54RdlEtsJZ1oe89mxsIsy9iCmhkrNbb7cZ9fmsgAWTOyF3Q2BQQxAdk
	CBPcCMaTBEiHFVt4/hmo10HzWP5LpVNrpwfZNlq+3YFdENjiT6UaEfTAOT23iicnyCIQr8Fa211
	AsdZC5c7McY0Jr7z/8cOt5fwqvgW0XL1GjuHDXfl/+pTWCo1xXNhNkqDk7x7uXtSQ4jxiqNc
X-Received: by 2002:a05:6871:213:b0:2f7:647b:c6f4 with SMTP id 586e51a60fabf-2f791e8eb9amr13450174fac.22.1751997916628;
        Tue, 08 Jul 2025 11:05:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpH26ohBVzKIZv6P47gOh2CkvHSKlAKxJ0PfUJSuuwH5wQQvrWdeGR1PAnwSvtMv5TiKQU6A==
X-Received: by 2002:a05:6871:213:b0:2f7:647b:c6f4 with SMTP id 586e51a60fabf-2f791e8eb9amr13450156fac.22.1751997916229;
        Tue, 08 Jul 2025 11:05:16 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2f78ff050a4sm2940504fac.7.2025.07.08.11.05.15
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:05:15 -0700 (PDT)
Message-ID: <745378273e83384a53c6f26d2c43f9c007078717.camel@redhat.com>
Subject: subscribe
From: Laurence Oberman <loberman@redhat.com>
To: linux-nfs@vger.kernel.org
Date: Tue, 08 Jul 2025 14:05:14 -0400
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

subscribe


