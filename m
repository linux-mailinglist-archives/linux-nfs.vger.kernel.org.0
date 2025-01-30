Return-Path: <linux-nfs+bounces-9786-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3307DA22F51
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9467E7A1524
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 14:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66101E3772;
	Thu, 30 Jan 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8LOhL+v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D6A1E8823
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246846; cv=none; b=IFb1WZRE6J53CYnXETwXcR5Av/bbHDfC5jU0x/4dbyBLVRzp4LNbz9dRhdStQVsAEMayaxyyGc48tCSVWXIqGGWYW3TiV84/vNHBA6LD5RKPO08W0OKl724uhGpeODLt52u4fI7e4R9jRwe5TYx+wwIczuwKGIe+RbcaMurTu7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246846; c=relaxed/simple;
	bh=HlK7FzKzs5bxpvt+QHT9VaW+K83VFQo97ibdfoZC+Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W40FrOKqoehBXrgLqHuLLgpEp5LD6Ny4duOmecuavHdZJ+z/rKCvSWDyO7qxv3zda7HQlFvZ3gXtuv7Ur/doniE1v0PGPPCYhsNDa9YNPn03BBK6Vh3kK4mqFKwPt2yB9iX2/6w4xOcr0C3oo3ADMq4PpDIxsmC9IgBqfA7s5zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8LOhL+v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738246843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2zRiEr3eq6BDcFgqFLPNUk3gUbnD04tngkxU7d9QZSg=;
	b=T8LOhL+vOSZoNvsRymHqv9lxXb42SzHqKkV0KZwsR6+sKnO4lzErBN7FY6uPTkUcN7pnPm
	k4EUtSSp1rvMtXkSbaKSC/bY7H+hVzJKTDYWHg15lgWgteg8qdH48MtxNM0Mutvm5xuU6r
	9U2Ijl2VHyeDnoIFb7x6yTReuJ4eesQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-s94T94FwOrGmpD23cdwsOQ-1; Thu, 30 Jan 2025 09:20:41 -0500
X-MC-Unique: s94T94FwOrGmpD23cdwsOQ-1
X-Mimecast-MFC-AGG-ID: s94T94FwOrGmpD23cdwsOQ
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6ecd22efbso133030685a.0
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 06:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738246840; x=1738851640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zRiEr3eq6BDcFgqFLPNUk3gUbnD04tngkxU7d9QZSg=;
        b=EcTpfthM0gNZbOTKvgZbZ6XqVliO1AvhsyRh6TW7jQ7JDj3u2BpA0A0AkE3wGMdhCx
         Urrvui7bJjLUC6falMerWtyenNRRN8Ave+hpbK0WN7P3AcI/hH+o+VH7FVgv6bdGeJcr
         T3NYWdynoJIAmfkk6O7YI28OV0D0qFizZ/UnRbNnYyGD7+HZraXvQrPIPM/vLxG6NEbx
         se7tvjgUqIPYEdLaVsqo4Ovvtucp1ljv5ZRMzrWhqeOwEnhZtymm2vZDz8GV1UXA9pes
         c4nFlEx+xWBLmXqwtIkF8SYUukEzePMYyP65o2aNhgbxtZCv0ryZJxzyD4PjZdqt291A
         qxPA==
X-Gm-Message-State: AOJu0YzwpmHEjPbIINQWm2oMzCzrOK4bcxuoSXLDEC6psVJ2WCCVamdW
	3y7GJ0EDfTpI4XANEkR4DXdjrauEMbOXsxdJQJqBeJGlBOBVRlDfGQPi45HTQ6KceKYEFbKM9S+
	lKREDxLEnLQUvz9nwgPlI6782G0pJ78vjDAAzMMzCWZzrYBDRdxy26WPVieq8hLhfPDg/DGjivk
	aSYkzDag0B5WWUqxCqZOS8bF2fIooMoMe3KBoAN0eJ9Q==
X-Gm-Gg: ASbGnctVbQSyj5kL1K+RUdtm5xL/dcfIvyUmzdnNFu/+dNX0WZ0h2VqKt7mcBTUIT0e
	vItp8cYalMG7zPpXvnwkOoZLZ6oc2OeczWaJYJDPAzMy6EKdznEjGe/FPHEVbH2o6M6Ph5Nw5RT
	//2utLqBBVwOyGmR4k/XIOTxb2/oepRnth5qkr2GnUaXchz75bIVea7oZkNaz/D9dNULAYxLlnY
	Woe4c7FtB6WHmB3/QQR8AstnKLn/Ih51hZSWUWnOia2YhM/AlxthdsslduWpdW+69/HRhpcXcAy
	yeFzYrvk8+pb9em3P882yv0u1VVIDmwTWYoJdP2mflfVCbFf3QFWANWmR2ZjeNPD
X-Received: by 2002:a05:620a:2cc3:b0:7b1:ab32:b71e with SMTP id af79cd13be357-7c009702666mr367527385a.0.1738246840128;
        Thu, 30 Jan 2025 06:20:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl0+hel9VhfVlph3Z1sYbaBMxZUHkOMDAbVeedCCVmvj91oMLu6+o1fAdKRCuxSbyp7umOCg==
X-Received: by 2002:a05:620a:2cc3:b0:7b1:ab32:b71e with SMTP id af79cd13be357-7c009702666mr367524585a.0.1738246839746;
        Thu, 30 Jan 2025 06:20:39 -0800 (PST)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a9205f4sm77449285a.114.2025.01.30.06.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 06:20:39 -0800 (PST)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: steved@redhat.com,
	chuck.lever@oracle.com
Subject: [nfs-utils PATCH 0/8] mountstats/nfsiostat: bugfixes for iostat
Date: Thu, 30 Jan 2025 08:19:59 -0600
Message-ID: <20250130142008.3600334-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is intended to fix several bugs in nfsiostat and
'mountstats iostat', in particular when an <interval> is specified.

Specifically, the patches address the following issues when printing
multiple times:

* both nfsiostat and 'mountstats iostat':
   - if <count> is also specified, the scripts sleep an additional
     <interval> after printing <count> times, and parse mountstats
     unnecessarily before checking the <count>

   - if no nfs mounts are present when printing, the scripts output
     a message that there are no nfs mounts, and exit immediately.

     However, if multiple intervals are indicated, it makes more sense
     to output the message and sleep until the next iteration; there
     may be nfs mounts the next time through.

   - if mountpoints are specified on the command-line, but are not
     present during an iteration, the scripts crash.


 * 'mountstats iostat':
   - if an nfs filesystem is unmounted between iterations, the
     script will crash attempting to reference the non-existent
     mountpoint in the new mountstats file (or if another filesystem
     type is mounted at that location, will instead crash while
     comparing old and new stats)

   - new nfs mounts are not detected


 * nfsiostat:
   - if a new nfs filesystem is mounted between iterations, the
     script will crash attempting to reference the non-existent
     mountpoint in the old mountstats file

   - if a mountpoint is specified on the command-line, but topmost
     mount there is not nfs, the script crashes while trying to
     compare old and new stats


To address these issues, the patches do the following:
 * when printing diff stats from previous iteration:
   - verify that a device exists in the old mountstats before referencing it
   - verify that both old and new fstypes are the same

 * when filtering the current mountstats file:
   - verify the device exists in the mountstats file before referencing it
   - filter the list of nfs mountpoints each iostat iteration

 * check for empty device list and output the 'No NFS mount points found'
    message, but don't immediately exit the script

 * merge the infinite loop and counted loop, and (for the counted loop)
    decrement and check the count before sleeping and parsing the mountstats
    file


Frank Sorenson (8):
  mountstats/nfsiostat: add a function to return the fstype
  mountstats: when printing iostats, verify that old and new types are
    the same
  nfsiostat: mirror how mountstats iostat prints the stats
  nfsiostat: fix crash when filtering mountstats after unmount
  nfsiostat: make comment explain mount/unmount more broadly
  mountstats: filter for nfs mounts in a function, each iostat iteration
  mountstats/nfsiostat: Move the checks for empty mountpoint list into
    the print function
  mountstats/nfsiostat: merge and rework the infinite and counted loops

 tools/mountstats/mountstats.py | 102 ++++++++++++++++--------------
 tools/nfs-iostat/nfs-iostat.py | 110 +++++++++++++--------------------
 2 files changed, 100 insertions(+), 112 deletions(-)

-- 
2.47.1


