Return-Path: <linux-nfs+bounces-16373-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 827F8C5B16E
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 04:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69F184E8962
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 03:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4DC2264CC;
	Fri, 14 Nov 2025 03:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG25Vppl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE8D1E51E1
	for <linux-nfs@vger.kernel.org>; Fri, 14 Nov 2025 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763090579; cv=none; b=KGEC/KSQ/J/1G5wKpaS9/9CdRd4G9z/jp+S3d4hMjTN7gmkwUuHFsoGdz5o2Pxc/t0xZayHPfHEr5Q9gGjEFnN/x7SbosPgZb12HXhbmy8YZ7xa/N2E0w8zFhs+4+DEKjoUASsmep0ealZhEwQGc3yKcj9CZKZIU987J3amhrBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763090579; c=relaxed/simple;
	bh=t5ktfVERDBQx8COUi5vs6RCmOQVjndPyrTkVUXogQUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZZyBJv9e77YSUSMgqgK/g2WAnkLHUjtdU3/Zn4RuETrwGnttsL44wTqZGzRCYc1P5y+f+pKp6VrqD0SMnoEMQE6PD8JdUsL5doPxCZW5+foEiKf2fE2taKB2dqWxqnd5RECtzqHYoTSfo0tTmJ+U87h4hcWeQ/rtJlBSsCO+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eG25Vppl; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4505ade79c2so724697b6e.1
        for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 19:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763090577; x=1763695377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5ktfVERDBQx8COUi5vs6RCmOQVjndPyrTkVUXogQUk=;
        b=eG25VpplHXPNMBizbKOLPzcpB+1o55BAR8KFSvlRxsAMuQS1VwafA6tOdfUNA1VG7t
         MBXJ0m4Ixw9qcCNI/a9SoQC64ixCSphYBhTqvNps+2Sescs/AOXz9FkuhipYNSzfJSqX
         EF6ArO0NlbeYsCX3tAGh33GzF5YVno8ISfSm8YSwCF+r2VF3uADTfcMQozXP1CDzDan3
         VS2wkC8s2qaJybb6ElpmQE2Ued59RM7CXCTotBURj0Rqc5GA72hGPMBk/FsqG17AXsrU
         I73EEDTTJmC2k104lBlrGb764pXGoQNa4vYAMzTCC/BOIK69kmrYXMMVl2EzmCEbqUka
         Hclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763090577; x=1763695377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t5ktfVERDBQx8COUi5vs6RCmOQVjndPyrTkVUXogQUk=;
        b=BzkWP6oSlJp76k/VQz5NhBNRv1Neg49s9pRumJVYSw63A2xao8BumEsBM+iMPAviCT
         rR9mnIzNzx97ML0PkTm/URbujD05n6VHjRNFa2I2iBeBKMSJf9Xq2Q+PHszg8gh+/OGf
         ovCQd+aRZFgWMmVZSQN/9ubj+Bgmkl98vzeZV6awwFpWHjdohepkjRDq9N50MdKeJudi
         MQvSdlQyvvLGBWObYVvizrv2b5bPR2MWWWHGXKuoYzxwKhRf6kK6xLyGFGqyrh32q+P1
         vDtbNFmfjVdbEOTaNdqzCmaDJhxiKLioL6CiRDZkiBRsUF4QVw8AGyOJWBp3biw0GGDf
         7Kpw==
X-Gm-Message-State: AOJu0Yx2p8Z7TX9wOYEZfDuvRmURk0BtIbRIES5zdNFg8KZ1dHDg3TjE
	14brcz/b1D8vF4WHewrnNROnfpXWo/ELAWpfexM6sZx10fr9OXv8C321PgE+1t6Jha4j7eMlJcb
	evwnABvUtnY5XDU+t5xa7cUjKmqWAIf0=
X-Gm-Gg: ASbGncuLU1lAFDs/HquNNpOkeSuRbrIlQBxMhBgNbxkucMjvoNBmaCnT920QIOz2a4v
	wm6UYJxGtRkwWjEIutQg0be53bzG+L5qu9802GwQWnj/6mSU6dmNz9OszdF/53Z5xXx/MA1VLwW
	1PWTj6ejH3y4vUsXOsrzGz+Gn8T6kRT0Zn88hxczfQrQWTcTl7a+qTG88p1TJNvLOnGg+8Xu6Vv
	1J3erUVzQnu257pQ3nuCj+4N5FJOIbv3NKnOes5Ez8lPrhDqMfv73Yjnd6Og4w=
X-Google-Smtp-Source: AGHT+IFMa2Z+JKTwsZv+27UioeCE+ca9aGuAXVkjl0sV4WUg/U/pMZkU5DH2OEKCi2lBFFO6ZMQogL8/AZ1NvUIGRlA=
X-Received: by 2002:a05:6808:6702:b0:44f:df33:7682 with SMTP id
 5614622812f47-450973ba6b6mr830311b6e.2.1763090576827; Thu, 13 Nov 2025
 19:22:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113093720.20428-1-gaurav.gangalwar@gmail.com>
 <d3b2e4c8-18ec-4b8f-a05f-42bc00196e1c@oracle.com> <CAJiE4O=zhEaJKQO7bBc8g9gXCiMoi7G7qSiVbQ5Cq+SwBK8OVw@mail.gmail.com>
 <fc58b0f2-d00b-4e4e-a353-ffe43bec6c6e@oracle.com>
In-Reply-To: <fc58b0f2-d00b-4e4e-a353-ffe43bec6c6e@oracle.com>
From: gaurav gangalwar <gaurav.gangalwar@gmail.com>
Date: Fri, 14 Nov 2025 08:52:45 +0530
X-Gm-Features: AWmQ_bk8fsp6Bvemtoo_4TUuB2ArUk-urh864jkCU9MPKd1HYl_s0s4UHt3NTKw
Message-ID: <CAJiE4OnqsKu9Z7VHz2KW+JWctFbQ8_vz8+82rDbZqZ=AVs-=NQ@mail.gmail.com>
Subject: Re: [PATCH] Make RPCRDMA_MAX_RECV_BATCH configurable.
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, neilb@brown.name, 
	Jeff Layton <jlayton@kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:11=E2=80=AFPM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 11/13/25 11:39 AM, gaurav gangalwar wrote:
> > On Thu, Nov 13, 2025 at 7:49=E2=80=AFPM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> >>
> >> On 11/13/25 4:37 AM, Gaurav Gangalwar wrote:
> >>> Bumped up rpcrdma_max_recv_batch to 64.
> >>> Added param to change to it, it becomes handy to use higher value
> >>> to avoid hung.
> >>
> >> [ Resend with correct NFSD reviewer email addresses and linux-rdma@ ]
> >>
> >> Hi Gaurav -
> >>
> >> Adding an administrative setting is generally a last resort. First,
> >> we want a full root-cause analysis to understand the symptoms you
> >> are trying to address. Do you have an RCA or a simple reproducer to
> >> share with us?
> >
> > Issue found while testing fio workload over RDMA
> > Client: Ubuntu 24.04
> > Server: Ganesha NFS server
> > We have seen intermittent hung on client with buffered IO workload at
> > large scale with around 30 RDMA connections, client was under memory
> > pressure.
> > Ganesha log shows
> >
> > 10/11/2025 16:39:12Z : ntnx-10-57-210-224-a-fsvm 1309416[none]
> > [0x7f49a6c3fe80] rpc :TIRPC :EVENT :rpc_rdma_cq_event_handler() cq
> > completion status: RNR retry counter exceeded (13) rdma_xprt state 5
> > opcode 2 cbc 0x7f4996688000 inline 1
> >
> > Which points to lack of posted recv buffers on client.
> > Once we increased rpcrdma_max_recv_batch to 64, issue was resolved.
>
> That still doesn't convince me that increasing the receive batch count
> is a good fix, though it's certainly a workaround.
>
> The client's RPC/RDMA code is supposed to track the number of Sends and
> keep the correct number of Receives on the Receive Queue. The goal of
> the implementation is to never encounter an RNR.
>
> Therefore, if it's not doing that (and the RNR retries suggests that's
> the case) there is an actual bug somewhere. The extra batch Receives are
> an optimization, and should have no impact on correct operation.
>
> If you can't reproduce this with the Linux NFS server, the place to
> start looking for misbehavior is NFS/Ganesha, as it is the newer NFS
> over RDMA implementation of the two servers. Maybe it's not handling
> credit accounting correctly, or perhaps it's putting more Sends on
> the wire than the credit limit allows.
Sure I will try to get more details.
Issue is specific to pNFS, for non pNFS shares we don't see this issue.
Even for pNFS we see hung when number of ds connections are high (30
ds connections)
But this work around is definitely helping.
>
>
> --
> Chuck Lever

