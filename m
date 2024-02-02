Return-Path: <linux-nfs+bounces-1713-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FB7847330
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 16:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5422281E50
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 15:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC26C145B3B;
	Fri,  2 Feb 2024 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHremUk/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B9E1468EE
	for <linux-nfs@vger.kernel.org>; Fri,  2 Feb 2024 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887928; cv=none; b=iJDtqPMaAYSyZSwQodr3wbB9mZ7k/glmd5QlzsmBFgtrnKsBsn9WE6ElfRPdaMTAm1iz4Urs9p7QahY83WEvObjpa03Uznt4QRJQxFnPbp5kXQYV9PQ0cCRwI3q4IZIZiYlJma/4xMa1g8LSBd9lFLRCvag0eqY/BPHGHnpOBMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887928; c=relaxed/simple;
	bh=LB2tM7M/vojvvD9pvT8qCxaHqoBfTDEqvLcRwrwirJ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FCbwP7sdoC8SRPEscFi9B3Nh6pJ53ThvbrRfQ0L2g2kq8sLIsz1CsABFIDkz7THRyc268/e0h3ccjWjaJu8QgVtDY5qHqwAsRv7WpBYKZIOPx5ygcM66q1gnIiRKsV2kAosh0/UVEvf2L9LjBUrZelRJzK708V0lRvqKsQeT68s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHremUk/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706887926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=IM5ZcaZa7yAGe/RxsbA0xm4coNhAXOwcBQuiu+U+L9A=;
	b=BHremUk/pC1rgp7l97kqqOvvgd9VtYx8AWzbGE1FkEB9PkJI+hSzUX2XrUt/nFSIZ0D+1g
	XyfWTkqxEeopVLZHszwcCPl8AktYzFel/nSSlbLnxqEtGBoficbrBjMf6syMAUQwsgEtJg
	rg8cKZebEK0iVNUPTCI2yy/VsaiWcZw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-2QE5X3phO9-9LTyInNl8-Q-1; Fri, 02 Feb 2024 10:32:05 -0500
X-MC-Unique: 2QE5X3phO9-9LTyInNl8-Q-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-296379c79e8so967685a91.3
        for <linux-nfs@vger.kernel.org>; Fri, 02 Feb 2024 07:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706887923; x=1707492723;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IM5ZcaZa7yAGe/RxsbA0xm4coNhAXOwcBQuiu+U+L9A=;
        b=X2Fu+cMZhUqIXmueLG1lTBhVieRo97KNNKO6xa2mq23+cQLP75aG3hWA4FCSyUbykq
         buy1K+IaHU4siFib5rXAvTfHkXD/w99cpynBgHEFwBjr/spCojqvtMSOe4ZhA0XtdTX+
         ouRB4+zFJihmQcEfqHxt2dwg+pSwmLWfZLoTSbUbmQTXsVoPnJRpM36Z3OMcIEKF7hbW
         oyMOcu7WHhXpmvrqsd7WQQH8qMToI3ngatdRUtwLcSp7Egh0mYDsCflV7/TaTS8S96S7
         42msC0Yy/tzLM4O5QauklyXy7YVyKrT+oYBJQkDdUgdeCZVMITCt9E4exzHTmyS62IP7
         Yhuw==
X-Gm-Message-State: AOJu0Yz+NuAzCaa41pYQxTIV3acIdnApj65MgkhP4YBu4cz0uSWR2mn1
	x7qmZCo+4pPmCdmwkFnvaBSmCeJCz0wqy3X8eTy426EOBDlEfusjG4nqMpldqatv1DULRtV1eou
	1ebNoUErf3OxujLU19UscjLrhei+RIDDNEzO5PFt/3g7zzgTF9xWz1C1NRPW9Dv9SDUCrURTLFP
	a1NsfHfGy0o6sTzcrSWC2GNxK/vAiFm0M2kBsAFPO8MzY=
X-Received: by 2002:a17:90a:744e:b0:295:e24b:62e with SMTP id o14-20020a17090a744e00b00295e24b062emr7819862pjk.6.1706887923775;
        Fri, 02 Feb 2024 07:32:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF03sJR3jRWqPFscANuSc2fRI9wXu+W40DwRQn5GP605LFjRa33EKNRS0ysXmGh0QHmT1WpDp6Hp9YV+m8zQC4=
X-Received: by 2002:a17:90a:744e:b0:295:e24b:62e with SMTP id
 o14-20020a17090a744e00b00295e24b062emr7819845pjk.6.1706887923501; Fri, 02 Feb
 2024 07:32:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 2 Feb 2024 16:31:51 +0100
Message-ID: <CAFqZXNu2V-zV2UHk5006mw8mjURdFmD-74edBeo-7ZX5LJNXag@mail.gmail.com>
Subject: Calls to vfs_setlease() from NFSD code cause unnecessary CAP_LEASE
 security checks
To: linux-nfs <linux-nfs@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

In [1] a user reports seeing SELinux denials from NFSD when it writes
into /proc/fs/nfsd/threads with the following kernel backtrace:
 => trace_event_raw_event_selinux_audited
 => avc_audit_post_callback
 => common_lsm_audit
 => slow_avc_audit
 => cred_has_capability.isra.0
 => security_capable
 => capable
 => generic_setlease
 => destroy_unhashed_deleg
 => __destroy_client
 => nfs4_state_shutdown_net
 => nfsd_shutdown_net
 => nfsd_last_thread
 => nfsd_svc
 => write_threads
 => nfsctl_transaction_write
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe

It seems to me that the security checks in generic_setlease() should
be skipped (at least) when called through this codepath, since the
userspace process merely writes into /proc/fs/nfsd/threads and it's
just the kernel's internal code that releases the lease as a side
effect. For example, for vfs_write() there is kernel_write(), which
provides a no-security-check equivalent. Should there be something
similar for vfs_setlease() that could be utilized for this purpose?

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2248830

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


