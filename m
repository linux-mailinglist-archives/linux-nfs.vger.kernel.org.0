Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB1F6B04B0
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Mar 2023 11:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCHKit (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Mar 2023 05:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCHKis (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Mar 2023 05:38:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EBC7BA07
        for <linux-nfs@vger.kernel.org>; Wed,  8 Mar 2023 02:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678271854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0L8FZid4N7P9MdijKVAa5eEqgL3IuYPUm/CexmqP84s=;
        b=e6MQdRxi1lr0gVw2S1V1IveRysGJ/mQkwt1oM1HX0KmylQYOE/R+/Df48flnX3w8XcHvu9
        fcOsJsilUis7dJaIqU0qQcW/fpQjIs2vzfrc7vG5M49ipbVRxR0bUVTFOE/lHyf9DVx/bJ
        oeV36gES0wC4mbmOFNHmmfZyMpe6v20=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-SkXTkqk6OteHKBRtuuny6g-1; Wed, 08 Mar 2023 05:37:33 -0500
X-MC-Unique: SkXTkqk6OteHKBRtuuny6g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 032A985A5B1;
        Wed,  8 Mar 2023 10:37:33 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51F7A14171B6;
        Wed,  8 Mar 2023 10:37:31 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] SUNRPC: Fix a server shutdown leak
Date:   Wed, 08 Mar 2023 05:37:29 -0500
Message-ID: <F4367E72-25E7-432F-A19C-4A480DF63BD4@redhat.com>
In-Reply-To: <FA64D05E-9902-4C37-9F14-40E3EEA3B656@oracle.com>
References: <cover.1677877233.git.bcodding@redhat.com>
 <65d0248533fbdea2f6190faa1ee150d2d615344b.1677877233.git.bcodding@redhat.com>
 <FA64D05E-9902-4C37-9F14-40E3EEA3B656@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7 Mar 2023, at 22:14, Chuck Lever III wrote:

>> On Mar 3, 2023, at 4:08 PM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>>
>> Fix a race where kthread_stop() may prevent the threadfn from ever get=
ting
>> called.  If that happens the svc_rqst will not be cleaned up.
>>
>> Fixes: ed6473ddc704 ("NFSv4: Fix callback server shutdown")
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> ---
>> net/sunrpc/svc.c | 6 +++++-
>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index 1fd3f5e57285..fea7ce8fba14 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -798,6 +798,7 @@ svc_start_kthreads(struct svc_serv *serv, struct s=
vc_pool *pool, int nrservs)
>> static int
>> svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nr=
servs)
>> {
>> + struct svc_rqst *rqstp;
>> struct task_struct *task;
>> unsigned int state =3D serv->sv_nrthreads-1;
>>
>> @@ -806,7 +807,10 @@ svc_stop_kthreads(struct svc_serv *serv, struct s=
vc_pool *pool, int nrservs)
>> task =3D choose_victim(serv, pool, &state);
>> if (task =3D=3D NULL)
>> break;
>> - kthread_stop(task);
>> + rqstp =3D kthread_data(task);
>> + /* Did we lose a race to svo_function threadfn? */
>> + if (kthread_stop(task) =3D=3D -EINTR)
>> + svc_exit_thread(rqstp);
>> nrservs++;
>> } while (nrservs < 0);
>> return 0;
>> -- =

>> 2.31.1
>>
>
> Seems sensible, applied. Is there a bugzilla link that should be includ=
ed?

No, the issue was found in a private environment.

Ben

