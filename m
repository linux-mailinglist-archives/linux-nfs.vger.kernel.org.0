Return-Path: <linux-nfs+bounces-2232-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FFC875185
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Mar 2024 15:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 980A3B25059
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Mar 2024 14:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C8212E1C2;
	Thu,  7 Mar 2024 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q16+2tkq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CB412CDBE
	for <linux-nfs@vger.kernel.org>; Thu,  7 Mar 2024 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820580; cv=none; b=INg2WQQXP2TIYt6qTtyK74iSaUFnFHLvwtmp8135IqeWjVwi4ectof5DoUywcUT9eXbpvwVPg5pvI/jftUp9J8T9hPu3I2qCv2NmIrtEw+p8OyJxn1PJO60IEza2k7oTbRe6maSmO5TqwGnGLGD1/0o0Bm64+5vVcJKfy2N3t0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820580; c=relaxed/simple;
	bh=y84S2Z0jnZaBjanw6DC1LDa/yDQ8vJGbVk0tGKPgZ6U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XeL7E0ItfPIjcYiTQE4gBlH325oo3rwuc/fn6ziQoSbt8PofdQh77jRob+OriCk2ZEavMnkGY/LcUK9xecFM/VBv/d5FGiJ7FDl2mMrMVPuo+hDzps4w5mnWDpG3dlSg+vmCCM+yegkNpB/lJBnpUBmyrqU3GSn0LvQXzS7zVBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q16+2tkq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709820577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dEOWh0oXukXJlnalzgty0A1I2wzODMzK+vTK/vpIuWU=;
	b=Q16+2tkqvs40HHL6Twa2fcMSsZpZ/CKXJKryxg0kmeB40E8qhxr+0mxllsX8gYsFW+nZ7+
	RTOFXOWKc5XHFwrrgCH07mNFungeT2n5AusaOoBMFfKm6cQ07fvQfFFwTI891CqTXvWpTq
	EJs45sIkFXtnSjvr7UCFW3nJOqS2WdE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-rxP2OuPCM6SLRDKQTLy2aQ-1; Thu, 07 Mar 2024 09:09:31 -0500
X-MC-Unique: rxP2OuPCM6SLRDKQTLy2aQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92FFB800264;
	Thu,  7 Mar 2024 14:09:31 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.22.8.198])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5BFCE17A96;
	Thu,  7 Mar 2024 14:09:31 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-nfs@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [BUG REPORT] not ok 1 Derive Kc subkey for camellia128-cts-cmac
Date: Thu,  7 Mar 2024 07:09:23 -0700
Message-ID: <20240307140923.16598-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi,

One of the RFC 6803 key derivation kunit subtests is failing.

cki-project data warehouse : https://datawarehouse.cki-project.org/issue/2514

Arches: X86_64, ARM64, S390x, ppc64le
First Appeared: ~6.8.rc2

TRACE:
# Subtest: RFC 6803 key derivation
    # RFC 6803 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:63
    Expected err == 0, but
        err == -110 (0xffffffffffffff92)
        not ok 1 Derive Kc subkey for camellia128-cts-cmac
        ok 2 Derive Ke subkey for camellia128-cts-cmac
        ok 3 Derive Ki subkey for camellia128-cts-cmac
        ok 4 Derive Kc subkey for camellia256-cts-cmac
        ok 5 Derive Ke subkey for camellia256-cts-cmac
        ok 6 Derive Ki subkey for camellia256-cts-cmac
    # RFC 6803 key derivation: pass:5 fail:1 skip:0 total:6
    not ok 1 RFC 6803 key derivation
-- 
2.44.0


