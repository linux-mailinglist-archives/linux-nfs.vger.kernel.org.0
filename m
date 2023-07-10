Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A0C74E123
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 00:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGJWbo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 18:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjGJWbn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 18:31:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C5CE4C
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 15:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689028254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sprl8Dx/mbPP9Dbcjqw0Eibvvp5GFGW3DNeDZDSvCXE=;
        b=T3PQV3lnVvBF/sHW7kAp5lt8+HvjsyV6OK793ROKgIbVHKamyl/fU+/1t32gqdau3X2pWd
        R30mBlZ7sihdLmPMXqkVsGIv34xJgvl8DcAWhEibcGyQ/VRkLc8xYmMlhhAnrWMzZW6g5t
        3jwcxtNKbw0Nf/NW+1aEJDJRuJH/tBg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-EM_GTSZZORO2dlHANiIcJQ-1; Mon, 10 Jul 2023 18:30:53 -0400
X-MC-Unique: EM_GTSZZORO2dlHANiIcJQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7673e4eee45so450811785a.0
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 15:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689028252; x=1691620252;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sprl8Dx/mbPP9Dbcjqw0Eibvvp5GFGW3DNeDZDSvCXE=;
        b=hbRd8GM8HbfgB4EmLbxf9vmwO3i8j51knc4vlDhxQWMLFJk4XzJHH74pFW+C/nx/ZW
         xafTszeOLmqNQgKcTIuU1lg0ILGsTIqcextOjdUk2LazpsaENhuXrKGVwBC97BpCkcQy
         HM0s1l3UAepPtosve2olwXmup+/bYle0PfXJ3FYHoPfqmSJedZdK6rMM2iODQTmYxBnD
         nW2BicE0VKCnw4kpqXJvAFWcrDWoC1OW14G9q0irZEMtxt1gCwEBhxBqMO5YVJc+RPMW
         dNnN6rMkJ40Jhz/5YhWmAO04leV8B9TXQaFcclZsPzObNo+MrQ1I+LxgInIhjmsMPmlB
         hXAQ==
X-Gm-Message-State: ABy/qLb2yrACgTv3iQBj+N0EUpyDZGVvl2RA6oymHJYBM+mxthAKsz94
        uLZou48KcNrZKb6p+E0yutOY+Ep7RUzzs6I+MQge31naI04bygGoJ0Zfa27JQJ6ADg+qT0ZMJzf
        3X3y9NVgTAS3I3sp1NDUUVocz5uyr
X-Received: by 2002:a05:620a:4416:b0:766:fb05:d7b4 with SMTP id v22-20020a05620a441600b00766fb05d7b4mr14776401qkp.57.1689028252235;
        Mon, 10 Jul 2023 15:30:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFFGvsZy5LiT/IXTWDqQZoT+Le+1vFWRYV45OqTSFCk6a1HjVLX5rUOomzVdyQMA1RZR6W60A==
X-Received: by 2002:a05:620a:4416:b0:766:fb05:d7b4 with SMTP id v22-20020a05620a441600b00766fb05d7b4mr14776388qkp.57.1689028252017;
        Mon, 10 Jul 2023 15:30:52 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id v2-20020a05620a122200b00767cdf23ee3sm307268qkj.92.2023.07.10.15.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 15:30:51 -0700 (PDT)
Message-ID: <a85a38468bf0af2f5cb38df2e1c20a8baa0bac6b.camel@redhat.com>
Subject: Re: [PATCH/RFC] sunrpc: constant-time code to wake idle thread
From:   Jeff Layton <jlayton@redhat.com>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        lorenzo@kernel.org, david@fromorbit.com
Date:   Mon, 10 Jul 2023 18:30:50 -0400
In-Reply-To: <168902752676.8939.10101566412527206148@noble.neil.brown.name>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
        , <168842927591.139194.16920372497489479670.stgit@manet.1015granger.net>
        , <168843152047.8939.5788535164524204707@noble.neil.brown.name>
        , <ZKN6GZ8q9NVLywOJ@manet.1015granger.net>
        , <168894969894.8939.6993305724636717703@noble.neil.brown.name>
        , <ZKwwFNeTw60Wuo+K@manet.1015granger.net>
         <168902752676.8939.10101566412527206148@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-07-11 at 08:18 +1000, NeilBrown wrote:
> On Tue, 11 Jul 2023, Chuck Lever wrote:
> >=20
> > Actually... Lorenzo reminded me that we need to retain a mechanism
> > that can iterate through all the threads in a pool. The xarray
> > replaces the "all_threads" list in this regard.
> >=20
>=20
> For what purpose?
>=20

He's working on a project to add a rpc status procfile which shows in-
flight requests:

    https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D366
--=20
Jeff Layton <jlayton@redhat.com>

