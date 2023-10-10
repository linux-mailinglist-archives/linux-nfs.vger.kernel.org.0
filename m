Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1C67C0258
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Oct 2023 19:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjJJROM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Oct 2023 13:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjJJROL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Oct 2023 13:14:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E3FB6
        for <linux-nfs@vger.kernel.org>; Tue, 10 Oct 2023 10:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696958006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xuZKeTojJH7CmJBVZYpMnwmGXP9i4stp2BEwVYBFEts=;
        b=Cp20iF8TwVV+/XNzbDwvajwsfL/ErXvlqmIJYcu8xfSiPKCcaqksN51bZJaFCEKRK6m3pg
        Oh++R6vwi+Z2MPVqyEfsNpCP73abosNU9omTsOMOCEbTR0UdEmO00Sr+Swfk9mveFQ8W9M
        X5VHpw1wqzwhKTKjZWYFDtswYco2Sjs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-bbjpn-P2PhaUGwzB0dJACg-1; Tue, 10 Oct 2023 13:13:25 -0400
X-MC-Unique: bbjpn-P2PhaUGwzB0dJACg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-65623d0075aso13919686d6.0
        for <linux-nfs@vger.kernel.org>; Tue, 10 Oct 2023 10:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696958004; x=1697562804;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xuZKeTojJH7CmJBVZYpMnwmGXP9i4stp2BEwVYBFEts=;
        b=MAYbpJd+MFmVGVNKdVlG6Rd4ioXSG7Tc9eDwncPLQQINz1i1NO0tImTqWqmF6fQi30
         qm0kigvZp5V6yFaaZ03fj5FENxFVdXTnAQ3213iWsdloLnAE0NEIBMNYIGm6nyh/xmYF
         APovZ2XhK7nMvlVBeYNSRV4iYGjhx9bULTry0XD8gWf5OGvpACU3LK7RpkJhEhr7kaD1
         jdMFJDD4YGH0kUSFYt0JWGJsUEY7KzxpphW+2ifWc/a0gp7+qatj+EE63HfgAlh0HD+X
         gO3JiHaxzX0U1BjF9hye9T1LWBHq1gyXh+nTdfoWhKebxPQGZfBF0czPw1f7EIPBo/3d
         EawA==
X-Gm-Message-State: AOJu0YxzCqeS4Xfwbrac8X2xLdgjKh8F5MiYxNU9Pkq/QSQmIeBIO7/u
        uVPAC109ul6RCyEzsozymk01nJG5jQXwtO+dqn2Rd6Zht7h0TOKLpm2dJB/HE5U/LLyxhyaYla8
        yczEXOizFE4eLkuim+6B/1gSVGvuWzSs7acXPyiGTjnqVNS8G+MsLo/6H6GnAD8FhhR9dmKIvYn
        gG446O
X-Received: by 2002:a05:6214:3018:b0:656:2e07:94cf with SMTP id ke24-20020a056214301800b006562e0794cfmr20047683qvb.3.1696958004566;
        Tue, 10 Oct 2023 10:13:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1DYGU2MnEXemEVoKr4vQcu+oGSH0OEKy0sR5aKB+gA9b0r+1DK7sayrMgOM6o+SHU7a2SoA==
X-Received: by 2002:a05:6214:3018:b0:656:2e07:94cf with SMTP id ke24-20020a056214301800b006562e0794cfmr20047651qvb.3.1696958004242;
        Tue, 10 Oct 2023 10:13:24 -0700 (PDT)
Received: from [172.16.1.21] ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id a24-20020a0cb358000000b0065b0554ae78sm4885925qvf.100.2023.10.10.10.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 10:13:24 -0700 (PDT)
Message-ID: <e6375a55-4b61-4a4b-9d49-bac96cb74135@redhat.com>
Date:   Tue, 10 Oct 2023 13:13:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Steve Dickson <steved@redhat.com>
Subject: Bakeathon 2pm EST talks
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The Bakeathon talks are starting Today, at 2PM EST

Feel free to join us via google meet at

https://meet.google.com/gyu-kmxt-rke

steved.

