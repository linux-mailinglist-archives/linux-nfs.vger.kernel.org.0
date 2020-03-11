Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B558181C46
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgCKP1w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 11:27:52 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33040 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgCKP1w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 11:27:52 -0400
Received: by mail-yw1-f66.google.com with SMTP id g66so169733ywf.0;
        Wed, 11 Mar 2020 08:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fBKope3FHRNnKg4RO8W9qi6yilUi38nzcxkXbybG/AA=;
        b=a5G/3ZUvZbsRhaQhddS9QjMhgNOExtJn1wNu74I9SedEGXhRm3EHxmWgzxk6WiVdTF
         vFojXbkFHh7n6x4NKxROO/+AFbFlGVH65Qjdp4sKkW7DRrEz7JU3S8mw9/TY2ns1Al8L
         XoqDg8+0IdeYrodSdEVCX8RGF56HzL0JvzFv8sURUqL9cNUb2o9c8gPSBT09DKiaYlw/
         YDbKJ0IiIpyLha8euLQaVLneoH+9nyQ/0Xf/q+pDOvIMH61jUSn5k3dlRbxWGX7EqghY
         QGu9YX2DhSnbZtoLJstds3C+0BRBFDXzD1Hh+5jIqKw/AUvvNfqHru6ZR3rxAHTnahgh
         SUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fBKope3FHRNnKg4RO8W9qi6yilUi38nzcxkXbybG/AA=;
        b=c6eCt0ChaGSyKQKdQugihz+Cdjq3khq6Nb5yz9RwN5720ePWK0Ks2qglPJlVLyKMSM
         kLNDj1/BOHI1jwcwBPUSOKl65HK7Fhurr4qLabb96gXjoKwsmMDwM6wo44oTXqKpNWwf
         41nUbQX5l8OQ0dAdUvXrScmunN1c4iOr8Jsn3+P69GX0ChcY2rLnIxorK25DuH5lfTnv
         UUMtsbfARX7tHF7iC6lbYbHwMgjuFdAkxgj0Q/5cDeSK0/lSYzS3/S3g3nvCchfnth4p
         qRIkd9yNtW2hkODOjocuPt6rZX5EzEsjVSlHgq4xjMFySVUiB53ncX9XH8EWUaUAOOYC
         bA5w==
X-Gm-Message-State: ANhLgQ1ijDfZnS9OZ0+G7vVP0frgfiy3K7rHBvoSrlaaY+Rh5g0hIWxN
        7E6J8I3fCehnhR2jaHrmi20kcEPAk8A=
X-Google-Smtp-Source: ADFU+vuwtDvK0ElmeygvV+0h2cBkN/QfT+fz2iYkRAxPjgYlZINM0Tl4TwnnB6Ime/y11K8OdLTlfA==
X-Received: by 2002:a25:83c8:: with SMTP id v8mr3427977ybm.201.1583940471200;
        Wed, 11 Mar 2020 08:27:51 -0700 (PDT)
Received: from anon-dhcp-153.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p2sm21546553ywd.58.2020.03.11.08.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 08:27:50 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 00/11] NFS/RDMA client side connection overhaul
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20200221214906.2072.32572.stgit@manet.1015granger.net>
Date:   Wed, 11 Mar 2020 11:27:49 -0400
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA5039EB-DDA0-44CA-B382-61BD544A330A@gmail.com>
References: <20200221214906.2072.32572.stgit@manet.1015granger.net>
To:     Anna Schumaker <anna.schumaker@netapp.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna, I don't recall receiving any comments that require modifying
this series. Do you want me to resend it for the next merge window?


> On Feb 21, 2020, at 5:00 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> Howdy.
>=20
> I've had reports (and personal experience) where the Linux NFS/RDMA
> client waits for a very long time after a disruption of the network
> or NFS server.
>=20
> There is a disconnect time wait in the Connection Manager which
> blocks the RPC/RDMA transport from tearing down a connection for a
> few minutes when the remote cannot respond to DREQ messages.
>=20
> An RPC/RDMA transport has only one slot for connection state, so the
> transport is prevented from establishing a fresh connection until
> the time wait completes.
>=20
> This patch series refactors the connection end point data structures
> to enable one active and multiple zombie connections. Now, while a
> defunct connection is waiting to die, it is separated from the
> transport, clearing the way for the immediate creation of a new
> connection. Clean-up of the old connection's data structures and
> resources then completes in the background.
>=20
> Well, that's the idea, anyway. Review and comments welcome. Hoping
> this can be merged in v5.7.
>=20
> ---
>=20
> Chuck Lever (11):
>      xprtrdma: Invoke rpcrdma_ep_create() in the connect worker
>      xprtrdma: Refactor frwr_init_mr()
>      xprtrdma: Clean up the post_send path
>      xprtrdma: Refactor rpcrdma_ep_connect() and =
rpcrdma_ep_disconnect()
>      xprtrdma: Allocate Protection Domain in rpcrdma_ep_create()
>      xprtrdma: Invoke rpcrdma_ia_open in the connect worker
>      xprtrdma: Remove rpcrdma_ia::ri_flags
>      xprtrdma: Disconnect on flushed completion
>      xprtrdma: Merge struct rpcrdma_ia into struct rpcrdma_ep
>      xprtrdma: Extract sockaddr from struct rdma_cm_id
>      xprtrdma: kmalloc rpcrdma_ep separate from rpcrdma_xprt
>=20
>=20
> include/trace/events/rpcrdma.h    |   97 ++---
> net/sunrpc/xprtrdma/backchannel.c |    8=20
> net/sunrpc/xprtrdma/frwr_ops.c    |  152 ++++----
> net/sunrpc/xprtrdma/rpc_rdma.c    |   32 +-
> net/sunrpc/xprtrdma/transport.c   |   72 +---
> net/sunrpc/xprtrdma/verbs.c       |  681 =
++++++++++++++-----------------------
> net/sunrpc/xprtrdma/xprt_rdma.h   |   89 ++---
> 7 files changed, 445 insertions(+), 686 deletions(-)
>=20
> --
> Chuck Lever

