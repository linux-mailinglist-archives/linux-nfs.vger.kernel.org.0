Return-Path: <linux-nfs+bounces-20144-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP7ICMoEtGnjfQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20144-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 13:36:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1332831BF
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 13:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A879430813EB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 12:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E7D38F647;
	Fri, 13 Mar 2026 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SA1sO63I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYfQBY8V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2250391846
	for <linux-nfs@vger.kernel.org>; Fri, 13 Mar 2026 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405248; cv=none; b=buO3ei5QqGP73YLBSHmz5QMzOGg1LsTwpO0FM6LymYm2mLxXC+DzKB6W0AmcUZ6A0bR9vI5yV/YZDlH/IV3lDpw0U2f3LI8vDhqOK+IRfdmpxSGjtA8kCxRQuRcGiczC9guWh0hINJyf44FVRue3eaD46wjNMRSProLIhUSUM2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405248; c=relaxed/simple;
	bh=0+jmGfASOQpL5pqp2GBWNab5/cK7ZIFZVpy9YoKuICs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=MAFllDcEsjBXaesYTSpcHDPA4LqfB5v82SRCySAIs0AAS22AG+b7Mivy0QWmU49szpgHwid3Cp2K7bCi8RS53xpXr2iUMF7WhOHHMvwa+w2iokNJc+Bz8AzfE0n2uhRvyprR2x5tI1Rjfx/C44j1nZZ0qdyU2YA4oGnycn9GbE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SA1sO63I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OYfQBY8V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773405243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9obGIpUR/NoWbwOoT3DbWmrgxAhcjPxe9q4vNT8R/gY=;
	b=SA1sO63IAFfkhQlgoxPLPFLSDNf0faGGh1lnI0PPWhObleyaIS2yTQrCtSwMoOeyNiQbAD
	33tVTFdIG82RtrkgFTToYXh4g+xf9Sn+NeAsiTFjd2a2iNqOanKuTIjLubw81iSGAqy6xq
	kLoXK4NA4EKIIJ4uruj4djckHO96310=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-yn_A4JBsM_a4zPe3zOcNzw-1; Fri, 13 Mar 2026 08:34:02 -0400
X-MC-Unique: yn_A4JBsM_a4zPe3zOcNzw-1
X-Mimecast-MFC-AGG-ID: yn_A4JBsM_a4zPe3zOcNzw_1773405242
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd7a25c5a9so1172632085a.2
        for <linux-nfs@vger.kernel.org>; Fri, 13 Mar 2026 05:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773405240; x=1774010040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9obGIpUR/NoWbwOoT3DbWmrgxAhcjPxe9q4vNT8R/gY=;
        b=OYfQBY8VkhouVaKsOMiysi4v+c7UDmvP3W7OeeJaY+bS0OK/bW3wR4vtEpeTjj1wDz
         TA6j67mjeIEqE2U2TUkWnOSwisml700HtQaD1zyNRIKQwk/jc2hpehrLWDuW29SM2WlY
         NBXdoObaGfWmLH7/FdenAmC/biY7hMD2wB+IzOMEPihukDunXkzsMcHzL8zYWe7IwT04
         hZT9eGYfzZRHHJpi+T9X0F+8IOWHfP716RiXsbaRJKwu4k1cDghZwMd60dhAxdYtYJ57
         z5RDYNqRBvklm48ryEdub0ZZDQeUgdNyucwAye2OfS4vm2lk57oc+3gvaQ1tTC3OWAGu
         2iWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773405240; x=1774010040;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9obGIpUR/NoWbwOoT3DbWmrgxAhcjPxe9q4vNT8R/gY=;
        b=MB8EPdhdspzyMuNy2mPvMWRsqPwKg51buKHVxNjFMWZEh+J/mCcpF6Ux1f2WeHl8Zt
         z2/wwsCc7EDo/fC7WUpWgAKzJ+9QlcbFIuGg1pz1YdSk0PZKAFdoRbNi0ApDB2DBnxv1
         IJnr6JZ9bwALSQiW0JFWtC5gHh3XjIEwm3U/NXiili0LgVFXApKacY0QE930u55/ocef
         vaFu+1Djoyq4wxpzdGt5at2EgArqTA0Ywci5qISxpPhTeHZARSMZMLcB/gCEvAFd6n50
         XiIwzpmLzJU3gJ6NT/fH8vxIQC/20r5POCm160rA5VpQ3EjueOuj3JFfOVJUZVYmbxJi
         tThw==
X-Gm-Message-State: AOJu0YwSRydAqvX0qgp0bwuV0jdnKmuP82yd6QMf+Wd8D0fakhtFzMlW
	5+MF56KB/O7kpFpkRIuvEG5Bw3ij1vo6Vz5b2osY96g+vuL2+PtBxIpP/6gFqETOfwE29qpXbRn
	iSqp3gY/uzfLWtvaxsgdSzRm2M8bPRIJb+jiHq4AzrPaJ+SLHHozeSgbJ4UWLF0qL61SHbQGXpB
	VQ8OP4lTO5zv+YiRmwgKU204ST/uVrEGj8FcUe7K4hsr4=
X-Gm-Gg: ATEYQzyf2bv0B4/dmLYrF/3jKNtxgga5L6yFyFIQDKunpZdZEkCJpT9h5BXqrlSYfgi
	AVqno84DEUSAG2AEQCaWZ8waXkzoKv47maU5c8uXI//UV3iSE2CH+PA2Axc/to5lTswQolUKpeO
	j11sqbzXEKR4nw8CU0L816Np49Wd5IX4mfOgzGWJmSjEbP20a++4E9S1yd0m8uLvGAwkpf8NUhj
	aXD/eq/Eek+pvOPq+rtvbLSybzWRarvZ+Hk2LAn5UjAHR458P1LbXIPY1Xi18R1doN3aZs5LHpZ
	G2EtNo6Q/PKH1rLxo3LaRoFaKid3lBxeYytdiFY+LsBuzMIJtBtMFkIFt+T6ICoM1LPemQC3JM3
	hwH1xiZ9A2cVfuJjoeDcQPA==
X-Received: by 2002:a05:620a:690d:b0:8cd:8ee7:446b with SMTP id af79cd13be357-8cdb5b3ce8fmr367908685a.55.1773405240237;
        Fri, 13 Mar 2026 05:34:00 -0700 (PDT)
X-Received: by 2002:a05:620a:690d:b0:8cd:8ee7:446b with SMTP id af79cd13be357-8cdb5b3ce8fmr367905485a.55.1773405239776;
        Fri, 13 Mar 2026 05:33:59 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.248.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fbcd2esm588237485a.5.2026.03.13.05.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 05:33:58 -0700 (PDT)
Message-ID: <4d11b9d7-7b49-4a1e-8c26-29ecb2fefe2f@redhat.com>
Date: Fri, 13 Mar 2026 08:33:54 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.8.7 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20144-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F1332831BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

This is a updated release of nfs-utils-2.8.7

     * Fixes the nfsrahead bug that was in 2.8.6.

This was a community effort of debugging and testing
this fix... Thank you all!

Also note there will be an upcoming release (2.9.1)
that will be tuning off NFSv4.0 by default on the server
which is already turned off in the client in 7.0 kernels.


The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.7/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.7

The change log is in
https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.7/2.8.7-Changelog
or
https://sourceforge.net/projects/nfs/files/nfs-utils/2.8.7/2.8.7-Changelog

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.


