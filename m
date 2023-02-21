Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C4169E216
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Feb 2023 15:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjBUOOd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Feb 2023 09:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjBUOOb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Feb 2023 09:14:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4B91BCC
        for <linux-nfs@vger.kernel.org>; Tue, 21 Feb 2023 06:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676988821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZQ4Udtq3475zSZNyZ7qGOKVeVUzgdKuQS0Hmf2iCbRI=;
        b=fSuYkZ+nQm3wZallpQC1kAskQAsVTs4sUzVvdvvP0/+t6QTFci7H8BFZUKjeV/eQaCRn2u
        3Grf4YDBQEX09Vcm2B/hhAXW9N11oaywOzn/bEQMwJy/HeC8qM36uzcQy3/UHbu0n2NeF4
        6DXpGXoVvuV5SlSZ6epBKahCWAJbwgc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-k76819HFM_e0FSlZdnU0Yw-1; Tue, 21 Feb 2023 09:13:37 -0500
X-MC-Unique: k76819HFM_e0FSlZdnU0Yw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8359D101A521;
        Tue, 21 Feb 2023 14:13:35 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2149492B04;
        Tue, 21 Feb 2023 14:13:34 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     =?utf-8?q?Florian_M=C3=B6ller?= 
        <fmoeller@mathematik.uni-wuerzburg.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Andreas Seeg <andreas.seeg@mathematik.uni-wuerzburg.de>
Subject: Re: Reoccurring 5 second delays during NFS calls
Date:   Tue, 21 Feb 2023 09:13:32 -0500
Message-ID: <785052D6-E39F-40D3-8BA3-72D3940EDD84@redhat.com>
In-Reply-To: <3b6c9b8e-2795-74e8-aefa-d4f1ac007c3c@mathematik.uni-wuerzburg.de>
References: <59682160-a246-395a-9486-9bbf11686740@mathematik.uni-wuerzburg.de>
 <8a02c86882bc47c1c1387dba8c7d756237cb3f3f.camel@kernel.org>
 <3b6c9b8e-2795-74e8-aefa-d4f1ac007c3c@mathematik.uni-wuerzburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21 Feb 2023, at 8:33, Florian M=C3=B6ller wrote:

> Hi all,
>
> unfortunately the patch did not help, neither using -o async nor using =
-o sync. We did some more tests (which is the reason for the delay of thi=
s reply):
>
> We used a qemu image housing both the NFS server and the client and did=
 some kernel debugging.
> OS: Ubuntu 22.04.1
> Kernel: 5.15.78
> Mount line: rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,
> 	namlen=3D255,hard,proto=3Dtcp,timeo=3D600,retrans=3D2,
> 	sec=3Dkrb5p,clientaddr=3D10.0.0.1,
> 	local_lock=3Dnone,addr=3D10.0.0.1
>
> We touched a file and then touched the file again. This triggers the de=
lay reliably.
>
> We set breakpoints on all functions starting with nfs4 and on "update_o=
pen_stateid". The attached file "1sttouch.log" contains a gdb log of the =
first touch.
> "2ndtouch.log" shows the gdb output of the second touch. The delay occu=
rs in line 116 in update_open_stateid.
>
> We then deleted all breakpoints and set a sole breakpoint on update_ope=
n_stateid. We touched the file again and used only the "next" command of =
gdb. The gdb output is in "2ndtouch-next.log", the delay occurs in line 8=
=2E
>
> Please let us know if you need more information or if you want us to pe=
rform further tests.
>
> Best regards,
> Florian M=C3=B6ller

Hi Florian,

The 5 second value and location of the delay is making me suspect somethi=
ng
is wrong with the open stateid sequence processing.

The client introduces 5-second delays in order to correctly order stateid=

updates from the server.  Usually this happens because there are multiple=

processes sending OPEN/CLOSE calls and the server processess them out of
order, or the client receives the responses out of order.

It would be helpful to have a network capture of the problem, along with =
the
matching output from these tracepoints on the client:

nfs4:nfs4_open_stateid_update
nfs4:nfs4_open_stateid_update_wait
nfs4:nfs4_close_stateid_update_wait
sunrpc:xs_stream_read_request
sunrpc:rpc_request
sunrpc:rpc_task_end

And these tracepoints on the server:

nfsd:nfsd_preprocess
sunrpc:svc_process

I'm interested in seeing how the client is processing the sequence number=
s
of the open stateid, or if perhaps there's a delegation in play.

LMK if you need help with the tracepoints -- you can simply append those
lines into /sys/kernel/debug/tracing/set_event, then reproduce the proble=
m.
The output of those tracepoints will be in /sys/kernel/debug/tracing/trac=
e.

Ben

