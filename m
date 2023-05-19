Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC447093EE
	for <lists+linux-nfs@lfdr.de>; Fri, 19 May 2023 11:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjESJp3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 May 2023 05:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjESJpE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 May 2023 05:45:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6930110FF
        for <linux-nfs@vger.kernel.org>; Fri, 19 May 2023 02:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684489220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N3zJTPy7+Wv3Siu08/r/1ERvBUA7DhrvgCru8QrTFQ4=;
        b=SkkOooGeAM6JktKvq63qZB8NfLRpmteD/ud/iFQZ7nl9ZUCYEMfwORjZDvLi7pEFeeO36P
        La1sTvd7biavmaPS0AvUDuxqKB9iL7o4k/ZNqgCLiq1J6Cy8J1eRJjVkssr1DBinbgwAC5
        iuLjgKeXuVkWk63qZno06UN3KsZPDt4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-2jnMJFdFOTWEH4gdEkMiMA-1; Fri, 19 May 2023 05:40:14 -0400
X-MC-Unique: 2jnMJFdFOTWEH4gdEkMiMA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 581028002BF;
        Fri, 19 May 2023 09:40:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7700A140E954;
        Fri, 19 May 2023 09:40:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAAmbk-f_U8CPcTQM866L572uUHdK4p5iWKnUQs4r8fkW=6RW9g@mail.gmail.com>
References: <CAAmbk-f_U8CPcTQM866L572uUHdK4p5iWKnUQs4r8fkW=6RW9g@mail.gmail.com>
To:     Chris Chilvers <chilversc@gmail.com>
Cc:     dhowells@redhat.com, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com, brennandoyle@google.com,
        Benjamin Maynard <benmaynard@google.com>
Subject: Re: [Linux-cachefs] [BUG] fscache writing but not reading
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1744184.1684489212.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 19 May 2023 10:40:12 +0100
Message-ID: <1744185.1684489212@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Chris Chilvers <chilversc@gmail.com> wrote:

> While testing the fscache performance fixes [1] that were merged into 6.=
4-rc1
> it appears that the caching no longer works. The client will write to th=
e cache
> but never reads.

Can you try reading from afs?  You would need to enable CONFIG_AFS_FS in y=
our
kernel if it's not already set.

Install kafs-client and do:

	systemctl enable afs.mount
	md5sum /afs/openafs.org/software/openafs/1.9.1/openafs-1.9.1-doc.tar.bz2
	cat /proc/fs/fscache/stats
	umount /afs/openafs.org
	md5sum /afs/openafs.org/software/openafs/1.9.1/openafs-1.9.1-doc.tar.bz2
	cat /proc/fs/fscache/stats

David

