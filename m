Return-Path: <linux-nfs+bounces-10566-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7287BA5E03B
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 16:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADFD189444F
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 15:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECF123F38A;
	Wed, 12 Mar 2025 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRhw7Doz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ED12033A
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792996; cv=none; b=CFjEfhdmZ+P+vFp7qwtGbWdA+Q96hFgUHXAiGCdZ/M18Nc/oegOeE9xB5Jjeu6D4+i7aWqyriwVs+LLTi4P46t21tD5rSVOkzYSYIo2a5+soIgBJxcqYh5AD1GNnLum8QRi+XfJjZWSf1vSY/l00otXqaa+U3SLiFB6M/WzIktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792996; c=relaxed/simple;
	bh=K0BVTyObCDLDhxErlpDCfQqm5s2fhj+rW06NBomYMqE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gcgcz/pbGaPsV7UOiIrTRwSr02a1Ba77sAbrqvQCvRFyWcnEZ6bYn8oicK+L50157ZfUF+BfW9aws1IpiFwk5gsgKJs5XlXjcnWt4sjM7VczXKfkfTGgTdi1D5RptbeSTUU62LESeu/3t28LFjA3r8yBw9rGv3fK4HiRY+uaJik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRhw7Doz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741792993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Ho+6i209qVGzxq2NpxF5gTmIsSqNsW8+lzO34LCTTKI=;
	b=PRhw7Doz7+iQs+wl0iyeVlNAIJOxT0p4q/GH0fs1iAUYlSQaBUx3LxzeQGRt3aKHckEsjP
	7IRZw+whxuQkKjXC6Q2DID4QxN12FoMUc4O0MZtX1nugjTidL60VQ0G9BQD+urF3z9Tuda
	NB4c2IllZEOduaUCGWtjnQovgHEqtd0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-ovAlrUAeNLaFBcM15FLAeg-1; Wed,
 12 Mar 2025 11:23:12 -0400
X-MC-Unique: ovAlrUAeNLaFBcM15FLAeg-1
X-Mimecast-MFC-AGG-ID: ovAlrUAeNLaFBcM15FLAeg_1741792991
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3B83180AF66
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 15:23:11 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.7])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CB2918001F6
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 15:23:11 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Historical reason for NFS_MOUNT_FLAGMASK?
Date: Wed, 12 Mar 2025 11:23:09 -0400
Message-ID: <37CB7B45-A199-4815-8D4A-95D06CDA2D0C@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

I'm looking for some bits in the nfs_mount_data.flags, and wondering why we
have only 16 bits masked off due to:

#define NFS_MOUNT_FLAGMASK     0xFFFF

Does anyone recall why we've limited the ABI to 16 bits here?

Ben


