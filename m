Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328F97CB527
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Oct 2023 23:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjJPVQB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Oct 2023 17:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjJPVP7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Oct 2023 17:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DE0B0
        for <linux-nfs@vger.kernel.org>; Mon, 16 Oct 2023 14:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697490910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1U0tJBCh6QXkNDFsuE/5Z4GonEge9xZ6toufdY0dp58=;
        b=LkMLLaJFUEBIg5+vwfXbMoFqBcTwYwtkKl063Y2EH3rdb3CCJOUdR/7OBUJklZbVupDO3w
        02d7JCXyya8S7c02SHJ69c9p7+j6HROZB3GEzhxuQCXgHxmMN4hNuArFoJOdkOW/VFuBLb
        gssNe2TFP/Bq4ZkIP+AQeuaykVypKiA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-33-9SReimbpOVKLTBdsOmnlPA-1; Mon, 16 Oct 2023 17:15:06 -0400
X-MC-Unique: 9SReimbpOVKLTBdsOmnlPA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D83863C17085;
        Mon, 16 Oct 2023 21:15:04 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98DE320296DC;
        Mon, 16 Oct 2023 21:15:02 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH -next v3 1/2] sunrpc: Wrap read accesses to
 rpc_task.tk_pid
Date:   Mon, 16 Oct 2023 17:15:01 -0400
Message-ID: <25740B27-9C85-46D9-8ACF-17D45D56A014@redhat.com>
In-Reply-To: <fb3bd4ed540bbe18f60bf1f700c110d662533503.1697460614.git.geert+renesas@glider.be>
References: <cover.1697460614.git.geert+renesas@glider.be>
 <fb3bd4ed540bbe18f60bf1f700c110d662533503.1697460614.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16 Oct 2023, at 9:09, Geert Uytterhoeven wrote:

> The tk_pid member in the rpc_task structure exists conditionally on
> debug or tracing being enabled.
>
> Introduce and use a wapper to read the value of this member, so users
> outside tracing no longer have to care about these conditions.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310121759.0CF34DcN-lkp=
@intel.com/
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I never work on kernels that don't have tk_pid, but I can say its so usef=
ul
that for 2 out of the 224 bytes that rpc_task uses (on aarch64), I'd be
inclined to just include it all the time.  That way its around for folks =
to
reference with realtime tools (like bpftrace, stap).

Does anyone know if there is a good reason not to include it for all
configurations?

Ben

=2E.also:
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

