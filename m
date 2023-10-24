Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2177D4EC5
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Oct 2023 13:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjJXLWw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Oct 2023 07:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJXLWv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Oct 2023 07:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE42412C
        for <linux-nfs@vger.kernel.org>; Tue, 24 Oct 2023 04:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698146526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lc4QRRS2JklUOevLDLT9C+dBiSZUF4pzfJM31OilF1s=;
        b=BkAtZpurcH5xLcsPv1a4NVgS6nqHuAYvXOq/dXD9CMlRipGXoI9LFqjAcbW5bfsyEhIg4L
        RvSyoB5WYnoshOc9pMf0qTo36YyMwDGVfIXHW9FgtkwIxRRYo+pA65iLOUG6Vjww7E12Zt
        w9OQao3LHeQiXlW9WsZsiECLrA0UoUo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-nqCPsGQHPNWOXlvRNLtfiQ-1; Tue,
 24 Oct 2023 07:21:52 -0400
X-MC-Unique: nqCPsGQHPNWOXlvRNLtfiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2901229AA39B;
        Tue, 24 Oct 2023 11:21:52 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6F191121318;
        Tue, 24 Oct 2023 11:21:51 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     =?utf-8?q?Elias_N=C3=A4slund?= <elias.naslund@kd.kongsberg.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Writing to NFS interfere with other threads in the same process
Date:   Tue, 24 Oct 2023 07:21:50 -0400
Message-ID: <FCF5E1D2-5DFD-4AA6-9BCF-7C902FFCCC80@redhat.com>
In-Reply-To: <PRAP190MB1833A3FAB75002DD5467B8ABCBDFA@PRAP190MB1833.EURP190.PROD.OUTLOOK.COM>
References: <PRAP190MB1833A3FAB75002DD5467B8ABCBDFA@PRAP190MB1833.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 24 Oct 2023, at 1:20, Elias N=C3=A4slund wrote:

> In an embedded application we're running a Yocto based linux distrubuti=
on with RT patches. One thread is writing data to a file on a NFS and ano=
ther thread is once every second running chronyc tracking with popen.
> The hardware is a dual core ARM with 1 gb of memory.
>
> The problem is that chronyc tracking doesn't return within 100 ms if bo=
th threads runs in the same application. If, however, each thread runs in=
 its own process it works as expected. It takes normally 10-20ms for chro=
nyc tracking to return.

The write_file() thread is queuing up a lot of async IO that is then
flushed by chronyc's do_exit -> put_files_struct -> filp_close, which wil=
l
be a synchronous wait for all that IO.

If that's not what you want I think you'll want to figure out how to drop=

CLONE_FILES from std::thread's clone(2) syscall.

Ben

