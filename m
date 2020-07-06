Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E622162F9
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2020 02:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgGGAZm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jul 2020 20:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGGAZl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jul 2020 20:25:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D19C061755
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2020 17:25:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e18so19154397pgn.7
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jul 2020 17:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=NFgTio3EcQB43mOZtcOelrlfYxHLjSBS4nimpndzq6A=;
        b=nMSzYDH9zHBi5e31s2S3v1SQF9J1uyNepuVLEWZYpEQrRVC7H7W3nB7zoFwfxm+QkJ
         fs1gfe4nJ2+nYE/kw5w2blQ+S54gfuN1ALfLDpiazVz9UuOn9OXf6KEy33xB7IcTIY+y
         RCPRGk6SqGz9FCHdt0nbYWjJyMQZ2Lf1Chg63Utp3yQo28/uSNfhFEeiCUV//E1FVVI/
         j/X0BcfzLeHJqrTwOLdxIOQUWz7evdNmvcLys9N4Lh2TXU9PeGiz3AObmf7Rfhl0yrly
         STskGnXGiXxvNDLKpXh+h7GSDiS4Zlfh1h0f8ueSe6Y4v3g7WLD8Lkxh54A9InPOgtxm
         n/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=NFgTio3EcQB43mOZtcOelrlfYxHLjSBS4nimpndzq6A=;
        b=KLkcJWMucKNO+hKPnUtJvkHGqrV8bvjwbIOgGiHK8Ppw3cZ90D3FPZ+Pmmzyw93BFS
         pmIkqNo95dj9ZS/OCKeNhcJN/T1J5Xzqm8Ac/27ljOVVGvPATyDJ+nVjAGYMfjnVTKQl
         KLX3KqSVvX5Cf/iLRF3JjnIFvSO0VBRNXWPsqf83NJdV7XhJ/jxSJSD0qERGly1Fc306
         6bcqbSvJ8eJsJMH36g4uLIz7mB4m3EOqD1njWb2mYjwHh9IE+QEAUl8LRP9vIXvf15b7
         ddwdxduP9cc5+o/e0mmVACld8d8EYn0C4qAGIzPAD/x37IeOdZJFPxwNvau9xYuKoRUm
         p07g==
X-Gm-Message-State: AOAM530l5o6n4jFp+4D+nd6ufxCjm6o/DLklNfAQPDG+y0MKXXvG42rD
        8gEs4VGhXXFag/RzLM7XsMIWug==
X-Google-Smtp-Source: ABdhPJzKLfzg3Y2QrBHUN/gvE0sDMS3J+l89xD9WwyUjPOlTPEXz9MsigFLqgDUe/8oQmeDJEFPAFQ==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr40170305pgj.19.1594081539980;
        Mon, 06 Jul 2020 17:25:39 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id cl17sm536699pjb.50.2020.07.06.17.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 17:25:39 -0700 (PDT)
Date:   Mon, 6 Jul 2020 16:41:31 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Fw: [Bug 208451] New: NFS server occasionally spontaneously reboots
 when client mounts exported directory
Message-ID: <20200706164131.78e0a4ef@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Begin forwarded message:

Date: Mon, 06 Jul 2020 02:11:42 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 208451] New: NFS server occasionally spontaneously reboots when client mounts exported directory


https://bugzilla.kernel.org/show_bug.cgi?id=208451

            Bug ID: 208451
           Summary: NFS server occasionally spontaneously reboots when
                    client mounts exported directory
           Product: Networking
           Version: 2.5
    Kernel Version: 5.7.7
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: nanook@eskimo.com
        Regression: No

This may be related to bug #208157.  From 5.7.0 through 5.7.4, nfs-server
would not start upon boot on one of my servers.

     With 5.7.7 this was resolved BUT now when I reboot one of the NFS clients
or unmount and remount an NFS partition on the client, the NFS server will
sometimes spontaneously reboot.

     I get these messages in /var/log/dmesg.0:

     (The old dmesg log I assume is relevant since it would be the active one
before the last boot).

[   40.302192] systemd[1]: Mounting NFSD configuration filesystem...
[   40.688313] kernel: RPC: Registered tcp NFSv4.1 backchannel transport
module.
[   69.899630] kernel: NFSD: Using UMH upcall client tracking operations.
[   69.899635] kernel: NFSD: starting 90-second grace period (net f00000a8)

     After the NFS server reboots I see these NFS related messages in dmesg:

[   53.810062] systemd[1]: Mounting NFSD configuration filesystem...
[   54.254326] RPC: Registered tcp NFSv4.1 backchannel transport module.
[  106.468779] NFSD: Using UMH upcall client tracking operations.
[  106.468781] NFSD: starting 90-second grace period (net f00000a8)
[  107.631713] NFS: Registering the id_resolver key type
[  110.815312] NFS4: Couldn't follow remote path
[  113.935404] NFS4: Couldn't follow remote path
[  117.055421] NFS4: Couldn't follow remote path
[  120.175488] NFS4: Couldn't follow remote path
[  123.295611] NFS4: Couldn't follow remote path
[  126.415625] NFS4: Couldn't follow remote path
[  129.545752] NFS4: Couldn't follow remote path
[  132.655844] NFS4: Couldn't follow remote path

     So pretty much the same thing except for the "NFS4: Couldn't follow remote
path" messages which I've read are caused by old nfs-utils not using the new
system calls so probably not relevant.

-- 
You are receiving this mail because:
You are the assignee for the bug.
