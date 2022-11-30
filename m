Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72F663D53C
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Nov 2022 13:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiK3MIx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Nov 2022 07:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiK3MIj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Nov 2022 07:08:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793A07643
        for <linux-nfs@vger.kernel.org>; Wed, 30 Nov 2022 04:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669810058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jnVdlteFV26Z76cEF4gxE55CdPW4P3QACX8nQF2ZXTo=;
        b=W/dSB4qs5hwMfYN4TjxxFnqFD4auu9K07/woj4RDIZunyWcd9qT2g9XoFZvOSjAqfTe4Ga
        sPDuA5GKhAnz1PJtE0E805fwucXHtgi6wF0TyYucotzcJnBT4lkI2YNflsI6f5EEvixFEq
        5X6WL3hpHvkVlHRo2bXgnkAdSZ4Yo+A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-518-ez1_AMZFPeC1O7R5m-sHXA-1; Wed, 30 Nov 2022 07:07:37 -0500
X-MC-Unique: ez1_AMZFPeC1O7R5m-sHXA-1
Received: by mail-wm1-f71.google.com with SMTP id l42-20020a05600c1d2a00b003cf8e70c1ecso907959wms.4
        for <linux-nfs@vger.kernel.org>; Wed, 30 Nov 2022 04:07:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnVdlteFV26Z76cEF4gxE55CdPW4P3QACX8nQF2ZXTo=;
        b=OvRGd68qPpLcrxbAV0SetMDJ1tpPjS1VuVr1ZgONPuLznM25q3hZ05BeNa0o4FJFa4
         ShEH9ZjuCGEiy35NDZou5PJYykoWrihEfqTfVbgJcdc7715Tp3Y93Mj1xVFRiLW7zjPm
         g+krT2BhYaO+K0ArwPmzKs4UAdksxw7sw5jN4KrO7CWzNovhPgCgJ35Qv3gl7w4ze2At
         eiXojWVPk0lKuKcZzxbRwlh0/BwWeVezkho6wc7P55griUr3LxyEcYQD/xC05dgD1M48
         wwLGFmTAlUTdch7Rh1P/hVDgoXSGw7Jv/4D14Rd2UZNCPdcwXwwomj9oJ+og2jnKBA1d
         6Jhg==
X-Gm-Message-State: ANoB5pn3cG47/7BAg6NfRP85Gg6SvT1WrqIAH5AOtjIV7wpHzOfElIP3
        ebfthVvpXPz8OPJmS2PUEQiOWfoUs9BfmSX/wAmCruxJ1xodV7hTpgzbgXj3pNPklIGXbI3T+FM
        XWrWBNQrHjzOsJQgSJBOx
X-Received: by 2002:a05:600c:3c8e:b0:3d0:69f4:d3d0 with SMTP id bg14-20020a05600c3c8e00b003d069f4d3d0mr4598111wmb.93.1669810056147;
        Wed, 30 Nov 2022 04:07:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4PpVsPubG71ps8rgagttNzK50w8zECDxzJfF2enqQnAPQgsvcgKe3HBaErdsIeSxrgevrHjQ==
X-Received: by 2002:a05:600c:3c8e:b0:3d0:69f4:d3d0 with SMTP id bg14-20020a05600c3c8e00b003d069f4d3d0mr4598054wmb.93.1669810055886;
        Wed, 30 Nov 2022 04:07:35 -0800 (PST)
Received: from pc-4.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id j3-20020adfd203000000b002366c3eefccsm1368822wrh.109.2022.11.30.04.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 04:07:35 -0800 (PST)
Date:   Wed, 30 Nov 2022 13:07:32 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Steve French <sfrench@samba.org>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Xiubo Li <xiubli@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-nvme@lists.infradead.org, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, v9fs-developer@lists.sourceforge.net,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 2/3] Treewide: Stop corrupting socket's task_frag
Message-ID: <20221130120732.GB29316@pc-4.home>
References: <cover.1669036433.git.bcodding@redhat.com>
 <c2ec184226acd21a191ccc1aa46a1d7e43ca7104.1669036433.git.bcodding@redhat.com>
 <20221129140242.GA15747@lst.de>
 <794DBAB0-EDAF-4DA2-A837-C1F99916BC8E@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794DBAB0-EDAF-4DA2-A837-C1F99916BC8E@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 29, 2022 at 11:47:47AM -0500, Benjamin Coddington wrote:
> On 29 Nov 2022, at 9:02, Christoph Hellwig wrote:
> 
> > Hmm.  Having to set a flag to not accidentally corrupt per-task
> > state seems a bit fragile.  Wouldn't it make sense to find a way to opt
> > into the feature only for sockets created from the syscall layer?
> 
> It's totally fragile, and that's why it's currently broken in production.
> The fragile ship sailed when networking decided to depend on users setting
> the socket's GFP_ flags correctly to avoid corruption.
> 
> Meantime, this problem needs fixing in a way that makes everyone happy.
> This fix doesn't make it less fragile, but it may (hopefully) address the
> previous criticisms enough that something gets done to fix it.

Also, let's remember that while we're discussing how the kernel sould
work in an ideal world, the reality is that production NFS systems
crash randomly upon memory reclaim since commit a1231fda7e94 ("SUNRPC:
Set memalloc_nofs_save() on all rpciod/xprtiod jobs"). Fixing that is
just a matter of re-introducing GFP_NOFS on SUNRPC sockets (which has
been proposed several times already). Then we'll have plenty of time
to argue about how networking should use the per-task page_frag and
how to remove GFP_NOFS in the long term.

