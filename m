Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F57E6652FB
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 05:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbjAKEy5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 23:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjAKEyu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 23:54:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AC52AF2
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 20:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673412849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AwDGIIG2kEW7th9yR8DoIeZiikP/oVS4/IYm7KTM+N0=;
        b=brBsQQCOn3YNpLDRSqJ0fzxkPgWTd4vbAn6G6HjRvF4ftTEjYNlIg2wBSn3tcP5h2zfNIk
        jWqFpNqwVQdt3rHPjEQTY6pwwFqd6aMMsecCM9qO+H49BcBd/QzXarky/Q/461Wvi4a92Y
        V+yqgBm2DJ/BldL60Ie7/m7IEX5QWqQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-417-uo4knvkYPWitk3b2tv_E5w-1; Tue, 10 Jan 2023 23:54:08 -0500
X-MC-Unique: uo4knvkYPWitk3b2tv_E5w-1
Received: by mail-pg1-f200.google.com with SMTP id a33-20020a630b61000000b00429d91cc649so6082546pgl.8
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 20:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwDGIIG2kEW7th9yR8DoIeZiikP/oVS4/IYm7KTM+N0=;
        b=xhjQskUoXkOTHsFF9BJw/UOlWGM5TkeVp98+bQqCVFSv6eRAF1DV795XIallpyYttu
         DPNOZS6e05SFtztuyPy12qtZuDXp6lMoB0kQRBQh3T/IHiTUyby8TfC6/03UdeIXFgbN
         bluIkEvgPNsaBtU6qdvvyM3RCGD9EiTLcUApFp4J+ZbXoPIUoEcc2D1K/wnem22dH9n9
         zQdIxr6ls5oHCfL7HaxB1rAQcL5VK/SggIF1pJxWLJWQOCEs7dm513Rz5Cv2G36vcuPE
         89+mVU6gbN9G5gQbPcsK7vKqOfw11VMqnuvFdlgiMLy5fXu5W4OXroA06/aWJ+2lKW5G
         IE7A==
X-Gm-Message-State: AFqh2kqwHXapEn53xktJCveP8pkPGMvAk+yKXWDZ1WVX20mQhk7ZlL1E
        4XhUQrdW8LLvSkHTPF+TfQUS/O3TObCcMIoydSe3IfHXcEWDRaCUMVsFq7vuS8bMXAjYvQraoqV
        /Bc3bDLVPCB2Iwv0p76WC
X-Received: by 2002:a17:903:50e:b0:189:bda4:4a39 with SMTP id jn14-20020a170903050e00b00189bda44a39mr68317522plb.49.1673412846877;
        Tue, 10 Jan 2023 20:54:06 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs+9rrIRD+6pRvHkwnX14gh2BCpLNg+4mxFg/ySKLAFpFMrHGq/R+Lf/NnqdSw7vAx/2ZYhMg==
X-Received: by 2002:a17:903:50e:b0:189:bda4:4a39 with SMTP id jn14-20020a170903050e00b00189bda44a39mr68317481plb.49.1673412846568;
        Tue, 10 Jan 2023 20:54:06 -0800 (PST)
Received: from [10.72.14.8] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902654b00b001895d87225csm8944870pln.182.2023.01.10.20.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 20:54:05 -0800 (PST)
Message-ID: <330d1f1b-02b2-ceb1-5df5-ef6ce0061eb2@redhat.com>
Date:   Wed, 11 Jan 2023 12:53:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] filelock: move file locking definitions to separate
 header file
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ilya Dryomov <idryomov@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Steve French <stfrench@microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        devel@lists.orangefs.org, linux-xfs@vger.kernel.org
References: <20230105211937.1572384-1-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230105211937.1572384-1-jlayton@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 06/01/2023 05:19, Jeff Layton wrote:
> The file locking definitions have lived in fs.h since the dawn of time,
> but they are only used by a small subset of the source files that
> include it.
>
> Move the file locking definitions to a new header file, and add the
> appropriate #include directives to the source files that need them. By
> doing this we trim down fs.h a bit and limit the amount of rebuilding
> that has to be done when we make changes to the file locking APIs.
>
> Reviewed-by: Xiubo Li <xiubli@redhat.com>
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: David Howells <dhowells@redhat.com>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Acked-by: Steve French <stfrench@microsoft.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   arch/arm/kernel/sys_oabi-compat.c |   1 +
>   fs/9p/vfs_file.c                  |   1 +
>   fs/afs/internal.h                 |   1 +
>   fs/attr.c                         |   1 +
>   fs/ceph/locks.c                   |   1 +

ceph part looks good to me.

Thanks

- Xiubo


