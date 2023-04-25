Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD45D6EE218
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Apr 2023 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjDYMp4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Apr 2023 08:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjDYMpt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Apr 2023 08:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC275274
        for <linux-nfs@vger.kernel.org>; Tue, 25 Apr 2023 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682426702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wf0fhdw+3rWrOecRA3zwu2+0L3kyzE2lraz3O9p0fVY=;
        b=X0EwAPps6aDmZOjRH9K7HQmCoPp3vWli02CrcrnSIcHEFcZYkCsOKdhwnKnVDTK74oWY9N
        pHckDdriogS/nuzAv2hSJd58g695C5XtYOfhRyxhsCdvm5WoBcjmoe5i/gnwCeipK3NtQU
        oVWdYQqfhK91zD+jEZ0Y6S9Ler1pazI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-iEJDoO38MoGZCuuXcjK1VQ-1; Tue, 25 Apr 2023 08:44:59 -0400
X-MC-Unique: iEJDoO38MoGZCuuXcjK1VQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-74faf5008bbso24860685a.0
        for <linux-nfs@vger.kernel.org>; Tue, 25 Apr 2023 05:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682426698; x=1685018698;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wf0fhdw+3rWrOecRA3zwu2+0L3kyzE2lraz3O9p0fVY=;
        b=DBK7oJVEC6i3aLOzhuK9Zj8xKrWm62Mx60pVGdETtU++5t64rURdThpBLJThCGKYFR
         /PyzumyCir/6TZuCAmbFRLZG/x6JdkT8xHgzDlk2H+bzKZvMLcF6x19QpvxK1RBLiDts
         0a9VS+pGQ2HQDolgQwP6S9w5qRB3Y95d7jwGOXjmm3iH0pq23yBHkRbmJYXAu1ZkeqB8
         NyqE/C9ZmP47MODShHB9t3NY7KOW87PFXh9qmUTgUZrcpIhgMV/PtIxtjWLiR3nBaHr7
         T+Q50N0m7Ayj6w1M038kIAIqCnvQ36pXaAdWT5qAIcXva3Xxuog3St7DGMX1y9kF1Gki
         Y41A==
X-Gm-Message-State: AAQBX9dnkUmUeh0DBqz1MGr5O3AS2FgrUnQBmMCn5cuoQHyFB2K1V4V/
        khJfOxcd46qTJpVhRXHm37iMWqtl+ISoNgVYStTU2ileUHYSz6polofawpHO2OMXygJ3p8NEPsn
        cpPGyIfUUIkK9FMiuis0k
X-Received: by 2002:a05:622a:1898:b0:3e6:707e:d3b1 with SMTP id v24-20020a05622a189800b003e6707ed3b1mr26058953qtc.0.1682426698524;
        Tue, 25 Apr 2023 05:44:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZYKy1jpuVY/jxVctfhaMCvJ5yYgteTaZewzrrRNcUdLg4h31cxtLg/3DbwFG56qJorpkZDlA==
X-Received: by 2002:a05:622a:1898:b0:3e6:707e:d3b1 with SMTP id v24-20020a05622a189800b003e6707ed3b1mr26058935qtc.0.1682426698285;
        Tue, 25 Apr 2023 05:44:58 -0700 (PDT)
Received: from [172.31.1.12] ([71.161.80.57])
        by smtp.gmail.com with ESMTPSA id 9-20020ac85909000000b003ef573e24cfsm4098705qty.12.2023.04.25.05.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 05:44:55 -0700 (PDT)
Message-ID: <12ec5a2c-b340-cb66-7cf9-dfa726496430@redhat.com>
Date:   Tue, 25 Apr 2023 08:44:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Steve Dickson <steved@redhat.com>
Subject: Bakeathon Is On!
To:     nfsv4@ietf.org, linux-nfs@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

It started yesterday... We are doing some very good
testing... esp with RPC-with-TLS...

Feel free to join in... the instructions are at [1]
and are very easy...

steved.

[1] http://www.nfsv4bat.org/Events/2023/Apr/BAT/index.html

