Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76AB2F32CA
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jan 2021 15:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbhALORx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jan 2021 09:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbhALORw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jan 2021 09:17:52 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34839C061575
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jan 2021 06:17:11 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id y23so2269985wmi.1
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jan 2021 06:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=akZMJ9+AQtzAE1/UTxU/FP25RPQa5JBHdNHm/8wjbAQ=;
        b=r1Tr/Guyml0IF4kZIDj/2B1VCz0vDEOgrwzNnsBKwwzSEUwKoyeMkytMue1qP+niMN
         fU9v5RcZt4t/M+zrV9RfxbDTe6zLpZFkDlEEQ6mBjZRjmhtOWP5fU3q6c25ZPgDkR6T1
         O/1TWV4VNnHDa37s/J7YvSajFW9n0xvl36HNOV8iosT6Kr7IyhnvQxgz6/5OlC05V841
         JCH4D+rNXr8yoayYIMvPkbO7BwhMZAB8kKVH16aSEok2UnTpOmtnVK34lib05oh6xEvs
         x0Zmn1hTypzTmWE/t+kAp9oti0i9ABw+KnN+wRIuU7UkwX7LtxkPemAKz64fJ00CB7kM
         vtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=akZMJ9+AQtzAE1/UTxU/FP25RPQa5JBHdNHm/8wjbAQ=;
        b=tcygxEhavvwxRqMh+TgxE5gJQT9iirE9yc/tM1T4QJ0ZFPwO7PuKqC8iozejjpaPdS
         a5k4gmoPNDieV4JeMa/ndHJe5b5asw/UuWbsjw2rhTTr6DM5jdeWdEIQgd5uUwbFfOqe
         Z0f+T01RLJsUmXM/lKkIUxWQ0Dc9+08uAFshk563GMuONx3TIweJwOecg8STMGKZjwq1
         W3sE+vbDUIBCjz1aYDTkSw5wyC3aFP9xWG0cL7A4ggcsbGndXWyp7kV2Lh1qv6S+f/0G
         DXRwYgapceHSjsiAYznMcUZdC3DBW7INsTrdntL1HEfI0p56kan07Qf5kOmmqjGv/cAW
         gNBA==
X-Gm-Message-State: AOAM531ut5McnzH0GkmBlgkvp7KqZUu4ZH+B4++yoryQfWNFXGv00YuA
        wGY/dANbuOzNStRRXEs5bUNfqA==
X-Google-Smtp-Source: ABdhPJzv3DwY+N98Ep9hwMmnAqd+MSVwlkG7qNcM5l7rbSKDLbRlNf/uhTuRHgbwna6COIngU970MA==
X-Received: by 2002:a7b:c184:: with SMTP id y4mr3846898wmi.92.1610461029881;
        Tue, 12 Jan 2021 06:17:09 -0800 (PST)
Received: from gmail.com ([77.125.107.115])
        by smtp.gmail.com with ESMTPSA id m14sm5206832wrh.94.2021.01.12.06.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:17:09 -0800 (PST)
Date:   Tue, 12 Jan 2021 16:17:06 +0200
From:   Dan Aloni <dan@kernelim.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Cc:     Jim Foraker <foraker1@llnl.gov>, Ben Woodard <woodard@redhat.com>
Subject: [RFC] NFSv3 RDMA multipath enhancements
Message-ID: <20210112141706.GA3146539@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond, Anna,

We currently have several field installations containing NFS and
SunRPC-related patches that greatly improve performance of NFSv3 clients
over RDMA setups, where link aggregation is not supported.

I would like work to integrate several of these changes to upstream, and
discuss their implementation. We managed to get a bandwidth of 33 GB/sec
from single node NFSv3 mount, and later around 92 GB/sec from a single
mount using further enhancements in RPC request dispatch.

The main change allows specifying multiple target IP addresses in a
single mount, that combined with nconnect and multiple floating IPs,
provides load balancing over several target nodes. This is good for
systems where load balancing is managed by moving a group of floating IP
addresses. This works especially well on RoCE setups.

The networking setup on these clients comprises of multiple RDMA network
interfaces that are connected to the same network, and each has its own
IP address.

The proposed change specifies a new `remoteports=<IP-addresses-ranges>`
mount option providing a group of IP addresses, from which `nconnect` at
sunrpc scope picks target transport address in round-robin. There's also
an accompanying `localports` parameter that allows local address bind so
that the source port is better controlled, in a way to ensure that
transports are not hogging a single local interface. So essentially,
this is a form of session trunking, that can be thought as an extension
to the existing `nconnect` parameter.

To my understanding NFSv4.x with pNFS has advanced dynamic transport
management logic along file layouts supporting stripe over file offsets,
however there are cases in which we would like to achieve good
performance even with the older protocol.

Before I adjust the patches I'm testing for v5.11, do you see other
implementation or user interface considerations I should take into
account?

Thanks

-- 
Dan Aloni
