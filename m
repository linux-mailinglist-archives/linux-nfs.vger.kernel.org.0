Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D509C6DCF2C
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Apr 2023 03:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDKBVI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Apr 2023 21:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDKBVI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Apr 2023 21:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0783D97
        for <linux-nfs@vger.kernel.org>; Mon, 10 Apr 2023 18:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681176025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=b1oILNqIsmmKonQ5+eRzWpaC0EaQtPUz1qB/y2cFzc4=;
        b=Ophrqh6KjSCtX5B5TmqnZ09BDrOa2sO0BSI39uIq7qJExGarNKU3iLHWZuRVXGUkGLhors
        W/11C8oc6WUHfoM+/d4yIIxzTF9fkWYrjQtwUT0+noL12W5GQ6Aw2z7ZXuFKDK3iz61gcv
        wHCTMF7vCqhIDy5I6baDVMAGo50uDEA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-GO04rz6rNk-QjqZ8leTbow-1; Mon, 10 Apr 2023 21:20:24 -0400
X-MC-Unique: GO04rz6rNk-QjqZ8leTbow-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-5df44ccedcaso12115946d6.1
        for <linux-nfs@vger.kernel.org>; Mon, 10 Apr 2023 18:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681176022; x=1683768022;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b1oILNqIsmmKonQ5+eRzWpaC0EaQtPUz1qB/y2cFzc4=;
        b=WGSV4qP0J271dh9OaSgM0O2rkQ3jOkDqw0u8KNU+UlCB4Iml5eB5k+pr/O1eUlFZMt
         90yu2E9kXlPOd9WfDsSDjSzOKY0ips+fwZDCOAEHs4BQ945dkgiVxZKctrcD2HAGUPnL
         OxfYSJO6FbhhuCNfnFx9EsWdRVH1P6c4D8kqP9tntD2giCnsFlyB0d0tjhyWyF/ey1RV
         xeYOvXFs8iuPN5/PgIMqmC7GBMsSoIEYCQFXv6hbp2N7ting+jpxUWVtnFHG+B0C65Me
         hI4K5sXdxuG67rIvR8k9zFtEiPaaXtO0UQytoI3oTzKbHuwbxPP3+k2gjh0Ck8+RzK5x
         hUBg==
X-Gm-Message-State: AAQBX9eotDS5aOZve3muP/o+HCJr85S2QsWLrdwI3VAyV+ChB52qw74m
        trmLxOvwwAICW1m1V2SKVA1LJ/VNPh/oLqDh+uKLqwoUexBMLYbbqqGyeECnSgGEBCuSbHH7R+W
        Pk0lL21WZt3tCZZQMpWmS
X-Received: by 2002:a05:6214:401c:b0:5ea:a212:3fe1 with SMTP id kd28-20020a056214401c00b005eaa2123fe1mr11300180qvb.4.1681176022294;
        Mon, 10 Apr 2023 18:20:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350bRfp+7SAi4feI6d25Ax7w9SmiLYXi0lDdoEAY11DE0Wy9Q27/JBlDGp6+0DoN2JCS32KDrFQ==
X-Received: by 2002:a05:6214:401c:b0:5ea:a212:3fe1 with SMTP id kd28-20020a056214401c00b005eaa2123fe1mr11300161qvb.4.1681176021987;
        Mon, 10 Apr 2023 18:20:21 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.174.138])
        by smtp.gmail.com with ESMTPSA id ea10-20020ad458aa000000b005dd8b9345acsm2811172qvb.68.2023.04.10.18.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 18:20:21 -0700 (PDT)
Message-ID: <3f09146c-b0b2-61f8-099d-9ccb16469b5f@redhat.com>
Date:   Mon, 10 Apr 2023 21:20:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Steve Dickson <steved@redhat.com>
Subject: Spring 2023 NFS bake-a-thon (reminder)
To:     nfsv4@ietf.org, linux-nfs@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

Just wanted send a quick reminder, that the Spring
bake-a-thon is two week out...

We have a new network this year that creates
peer-to-peer connects which we are hoping will
take care of the latency issues we have seen.

I've updated the the registration section
on the nfsv4bat.org web site [1] but it
basically says the following:

To gain access to the network please register
at the Spring Registration Doc[2].

Here are the steps to access the network.

	* Download the tailscale bits
		* https://tailscale.com/download
	* Register with the BAT server
		* tailscale up --login-server https://headscale.nfsv4.dev
	* The registration will give an authentication link
	* Use that link to
		* Create an account on the BAT server
		* Authenticate your machine[s]
		
Once the tailscale interface is up, DNS will be able to find other machines
	* The command 'tailscale status' will show those machines
	
The network is up and running... and it is very easy to
get connected... So please consider registering,
early the better!!

steved.

[1]  http://nfsv4bat.org/Events/2023/Apr/BAT/index.html
[2] 
https://docs.google.com/spreadsheets/d/1rs245drIdTQAiTSNZU3V0gpzhXNj5n-W2fJyy_iQIyM/edit#gid=0


