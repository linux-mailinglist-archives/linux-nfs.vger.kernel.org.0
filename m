Return-Path: <linux-nfs+bounces-12272-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9915FAD3D40
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 17:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61C61BA29A1
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 15:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27762242D6B;
	Tue, 10 Jun 2025 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dmix9/W2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15180242D6A
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749569049; cv=none; b=J5WwlI4EMO4Z9v8nTCKjlzLPAwn2+7EpbvcBtBwOaR6xsh9gUXmhSt7lXUcz4OlTi2Dbx82LU0zOrYDhHQK3H5sk/7sQQVqnPBENRQr8GilQg1FpEOXu1Q888XqTLTFOJ1GTzY3z/uH849VaQxliF0QkKh7wHeaiwWdJDqetvNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749569049; c=relaxed/simple;
	bh=xS91mNWpqKtMtHUoMZrbjY/5eEDkArVA5XbUIXQj6WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7/HnlKTGhq4l7HJepxpJoWMvu8SXifFPSqJJLpHzJ9tYkY6L/g9LzYdsX9g75RUs762/dL3WNN0zxdzBkXZum0dU1lphs4TPYmmfj3Oh4wSaSL1L4bNbGtm0rRXY3eY/yMOZgKza5sdVDhUuIJHY/Pp8ROYuBRqmTNwvujF/V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dmix9/W2; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso6677980e87.3
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 08:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749569045; x=1750173845; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QQjI1EADgz9zqmwZKNrsNxgx9PDXDzq5kZ83mfWvJ0=;
        b=Dmix9/W2gTjJsyT6HWq+sTqEmcPAVW/U4PN4qRQjNVmulhrqTcOPKjinZfDezATpRK
         C/An2BBfz7b5jrC3A7EPHAlSRsEtHXkdZU4tFVd7emdnxWxanWX4BZeJdeuiZI4l9w/i
         Hncz3TS2KQq1+Cp1rIoQnEsEGTeqRhLrokKl+2ZYdGEi+D8MGsvyEmQOkSt9QQLGUc+f
         cW4s/BoTQmxlLMLyWh/jG3EyvuVePViBSOvdx+hKDtzsxi+xn+TP8LbZFj/eONfgxutg
         SapNWV8RDTHDB2Si0kcRisVXC3sLeLMy7kUiSPwJcPEViJ64Z3kNIHUFzMeBHj8924BO
         mSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749569045; x=1750173845;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QQjI1EADgz9zqmwZKNrsNxgx9PDXDzq5kZ83mfWvJ0=;
        b=btSDrIp7N/oyfp7H4mV5yqrRhQl0pSOwWRbKVq+0k0CdGs2j/Fs81r3ZI9MQKlcZOQ
         dVvPacJm+4Kvs675gO/7Mmt96NJTekb2mACbJJP4hqmge2lmMDpEDiqxDx2Q2gCggLdD
         GpRPHyxULV/wTfUNR4o91DWYcqXg2Ug6G2XKqyoBZcAaqSL+LhO0kjW/2rr8TD8JlSMT
         3RHih2v3Y/jQUYwA2ejduwRJssI1AEtExfUgq2QD/9UuoR1QWk7l9YoeFdyABiYOVVXW
         j9+FELDymfroMJxyKdFp0c+T58U3etNYtAiUee93mGhtO1L1QjgiyRr3GgpVxxEmvfFm
         +qYA==
X-Forwarded-Encrypted: i=1; AJvYcCWKHbuWnKET+EcOnPcHh3gdgvzuoTQ+ySMASUGWrp7Kbm+49fuB+5FPJC99HBjrpJcXKia0Kk6bR9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6nBQO6DrnV65cErrtuHfTUkpRHpbF3Dsytu6a9BQ7HTT9F5jq
	p2NVsHaYhz7HTlY1zWTTf68uK6ZBAYwuT7ajOyFDfDd73db7H0E+aUb9
X-Gm-Gg: ASbGncvrC7xMaLZvOrsIBELaLjaz7UNMspWXzuodz/u4sLm27UAAYgtm9m5L/HBFeDc
	IcLp6XU4Udf8J5MB38Xnw++zVl2v3VBOv5ig4yHSB/MGOQirQY+BUqKstC9KVSqIiKq0vUwfLjv
	iTwaFfohTtC4LZEWZAPUq343BhaCIntPHlrHysVls7wzrocWeSLt3brhClDuGFBMpptP3D/jbz4
	1QDaYF+h+QFLVl+E/RtiMxgzjqPCVPKdpE2QL9XPVL4WDEJw7249FUSxVuEHTo3KChSSMwg14Ff
	x/NzTyAKeoOnGvGu4h1iBdzOiAGy13ioqnrHiaZlLF0Js95OQvFW8q+SlJG12wQCBiwq9iqRl7t
	roxdDI0qrMwVqmcsfb/sWIDWN
X-Google-Smtp-Source: AGHT+IGQrj84x7LBulKecnju1Mkl/bxUKaaRHML+ZfI2iC1fVYH0jkSUm6YIKkALOJaGpndNpvLxew==
X-Received: by 2002:a05:6512:3a84:b0:553:6583:8e6 with SMTP id 2adb3069b0e04-5539c0c8747mr2732e87.15.1749569044713;
        Tue, 10 Jun 2025 08:24:04 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.66.227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55367738956sm1588607e87.253.2025.06.10.08.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:24:04 -0700 (PDT)
Date: Tue, 10 Jun 2025 18:24:03 +0300
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, 
	"J . Bruce Fields" <bfields@fieldses.org>, Konstantin Evtushenko <koevtushenko@yandex.com>, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Implement large extent array support in pNFS
Message-ID: <75iqhi3to6gohuo2o4h3cewslcjzsfyrl7l7x2x3qyiaaecjci@uwoeqjubvqft>
References: <20250604130809.52931-1-sergeybashirov@gmail.com>
 <aEBeJ2FoSmLvZlSc@infradead.org>
 <uegslxlqscbgc2hkktaavrc5fjoj5chlmfdxhltgv5idzazm3h@irvki3iijaw4>
 <aEfE-r2dkuDRUKsq@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <aEfE-r2dkuDRUKsq@infradead.org>
User-Agent: NeoMutt/20231103

On Mon, Jun 09, 2025 at 10:39:06PM -0700, Christoph Hellwig wrote:
> On Tue, Jun 10, 2025 at 03:36:49AM +0300, Sergey Bashirov wrote:
> > Together with Konstantin we spent a lot of time enabling the pNFS block
> > volume setup. We have SDS that can attach virtual block devices via
> > vhost-user-blk to virtual machines. And we researched the way to create
> > parallel or distributed file system on top of this SDS. From this point
> > of view, pNFS block volume layout architecture looks quite suitable. So,
> > we created several VMs, configured pNFS and started testing. In fact,
> > during our extensive testing, we encountered a variety of issues including
> > deadlocks, livelocks, and corrupted files, which we eventually fixed.
> > Now we have a working setup and we would like to clean up the code and
> > contribute it.
>
> Can you share your reproducer scripts for client and server?

I will try. First of all, you need two VMs connected to the same network.
The hardest part is somehow to connect a shared block device to both VMs
with RW access. As I mentioned, we use a proprietary SDS for it. Note
that if you pass the device to the VM as virtio-blk, the client will
select the block layout driver, and if you pass the device to the VM
as virtio-scsi, the client will select the scsi layout driver.

Script I use to start VMs (both use the same parameters, only the names,
boot images and network addresses differ):
#!/bin/sh
BOOT_DISK="-drive format=qcow2,file=pnfs_server.img"
SSH_NET="-device virtio-net-pci,netdev=net0,mac=52:54:00:12:34:57
          -netdev user,id=net0,hostfwd=tcp::20001-:22"
NFS_NET="-device e1000,netdev=net1,mac=52:54:00:12:34:67
          -netdev socket,id=net1,listen=:1234"
MP="/dev/hugepages/libvirt/qemu"
VHOST_DISK="-object memory-backend-file,id=mem,size=8G,mem-path=$MP,share=on
             -numa node,memdev=mem
             -chardev socket,id=char1,path=/var/lib/storage/pnfs_server.sock
             -device vhost-user-blk-pci,id=blk1,chardev=char1,num-queues=16"
qemu-system-x86_64 -daemonize -display none -name pnfs_server \
                    -cpu host -enable-kvm -smp 8 -m 8G \
                    $BOOT_DISK $SSH_NET $VHOST_DISK $NFS_NET

The server's /etc/nfs.conf:
[nfsd]
grace-time=90
lease-time=120
vers2=n
vers3=y
vers4=n
vers4.0=n
vers4.1=n
vers4.2=y

The server's /etc/exports:
/mnt/export *(pnfs,rw,sync,insecure,no_root_squash,no_subtree_check)

Please note that the block volume layout does not support partition
tables, volume groups, RAID, etc. So you need to create XFS on the raw
block device. In my case shared virtio-blk disk is /dev/vda.
And the file system can be prepared by following these steps:
sudo mkfs -t xfs /dev/vda
sudo mkdir -p /mnt/export
sudo mount -t xfs /dev/vda /mnt/export

After these steps you can start or restart the server:
sudo systemctl restart nfs-kernel-server

On the client side, you need to have the same /dev/vda device available,
but not mounted. Additionally, you need the blkmapd service running.
Perform the following steps to mount the share:
sudo systemctl start nfs-blkmap
sudo mkdir -p /mnt/pnfs
sudo mount -t nfs4 -v -o minorversion=2,sync,hard,noatime,
                          rsize=1048576,wsize=1048576,timeo=600,
                          retrans=2 192.168.1.1:/mnt/export
                          /mnt/pnfs

This should create 2.5k extents:
fio --name=test --filename=/mnt/pnfs/test.raw --size=10M \
     --rw=randwrite --ioengine=libaio --direct=1 --bs=4k  \
     --iodepth=128 --fallocate=none

You can check it on the server side:
xfs_bmap -elpvv /mnt/export/test.raw

Troubleshooting. If any error occurs, then kernel falls back to NFSv3.
Use nfsstat or mountstats to view RPC counters. Normally the READ and
WRITE counters should be zero, and the LAYOUTGET, LAYOUTCOMMIT,
LAYOUTRETURN should increase as you work with files. If the network
connection and shared volume are working fine, then first of all check
the status of blkmapd, most probably its fault is the reason. Note that
the client code also has problems with the block extent array. Currently
the client tries to pack all the block extents it needs to commit into
one RPC. And if there are too many of them, you will see
"RPC: fragment too large" error on the server side. That's why
we set rsize and wsize to 1M for now. Another problem is that when the
extent array does not fit into a single memory page, the client code
discards the first page of encoded extents while reallocating a larger
buffer to continue layout commit encoding. So even with this patch you
may still notice that some files are not written correctly. But at least
the server shouldn't send the badxdr error on a well-formed layout commit.

> Btw, also as a little warning:  the current pNFS code mean any client
> can corrupt the XFS metadata.  If you want to actually use the code
> in production you'll probably want to figure out a way to either use
> the RT device for exposed data (should be easy, but the RT allocator
> sucks..), or find a way to otherwise restrict clients from overwriting
> metadata.

Thanks for the advice! Yes, we have had issues with XFS corruption
especially when multiple clients were writing to the same file in
parallel. Spent some time debugging layout recalls and client fencing
to figure out what happened.

> > As for the sub-buffer, the xdr_buf structure is initialized in the core
> > nfsd code to point only to the "opaque" field of the "layoutupdate4"
> > structure. Since this field is specific to each layout driver, its
> > xdr_stream is created on demand inside the field handler. For example,
> > the "opaque" field is not used in the file layouts. Do we really need to
> > expose the xdr_stream outside the field handler? Probably not. I also
> > checked how this is implemented in the nfs client code and found that
> > xdr_stream is created in a similar way inside the layout driver. Below
> > I have outlined some thoughts on why implemented it this way. Please
> > correct me if I missed anything.
>
> Well, the fields are opaque, but everyone has to either decode (or
> ignore it).  So having common setup sounds useful.
>
> > 2. When RPC is received, nfsd_dispatch() first decodes the entire compound
> >    request and only then processes each operation. Yes, we can create a new
> >    callback in the layout driver interface to decode the "opaque" field
> >    during the decoding phase and use the actual xdr stream of the request.
> >    What I don't like here is that the layout driver is forced to parse a
> >    large data buffer before general checks are done (sequence ID, file
> >    handler, state ID, range, grace period, etc.). This opens up
> >    opportunities to abuse the server by sending invalid layout commits with
> >    the maximum possible number of extents (RPC can be up to 1MB).
>
> OTOH the same happens for parsing any other NFS compound that isn't
> split into layouts, isn't it?  And we have total size limits on the
> transfer.

I agree, one large request and 1000 small requests look the same on the
wire. So, setting up an xdr_stream at a higher level requires adding it
to the nfsd4_layoutcommit strucutre. Either as a substructure, which will
significantly increase the overall size of the layout commit argument, or
as a pointer, which will require some memory allocation and deallocation
logic. Also, in the core nfsd code we don't know the sufficient scratch
buffer size for a particular layout driver, most likely we will allocate
a page for it. This all seems a bit overengineered compared to two local
variables on the stack. I will think about it a little more.

--
Sergey Bashirov

