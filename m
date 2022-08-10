Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74C058F3E8
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Aug 2022 23:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiHJVnt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Aug 2022 17:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJVns (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Aug 2022 17:43:48 -0400
Received: from smtpcmd01-ws.aruba.it (smtpcmd01-ws.aruba.it [62.149.158.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1815478597
        for <linux-nfs@vger.kernel.org>; Wed, 10 Aug 2022 14:43:45 -0700 (PDT)
Received: from [192.168.8.155] ([86.32.63.136])
        by Aruba Outgoing Smtp  with ESMTPSA
        id LtUNontjlr8wyLtUNoBOLy; Wed, 10 Aug 2022 23:43:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1660167823; bh=QCxRxmbQuIApGysGG9B0QIxEDbIDHK6u+qp8oRGYtyk=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=c4/sYuIOaCzzqRuo9Sz+hQhE6qxsp00E8UcZbaDkOkYPHWOWyeGqRSr6OcKp35IcT
         qB+5rbPVA80DNkTK2p3uO32V8FxraXGZ0uXeVXsxAwHJ+0xlhGstPn0YR6CD6gI/01
         hn06YLTadzHGHnfgqvgm+coXfpqQQy+uUWAqw5/oMlcPMVto7nVu+XAfT6sfE4WRdC
         zQg/uHDETVy49RQ0QlRwfoKgu5NylEmUjDUrWWCJxMsj/UHu/oTbiGEDTpqzWKDWBX
         tntIsULCIBm0sUq7LJyMvQ5Cz+/eCCPcnuNVPGXlHtHlf3Jpy5+K25evnbdpcuQbAZ
         EwJGA8ExpSbLQ==
Message-ID: <07d99979-a395-64a9-f051-e400bfefe1ca@benettiengineering.com>
Date:   Wed, 10 Aug 2022 23:43:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v2] nfsrahead: fix linking while static linking
Content-Language: en-US
To:     linux-nfs@vger.kernel.org
References: <20220809221252.772891-1-giulio.benetti@benettiengineering.com>
 <20220809223308.1421081-1-giulio.benetti@benettiengineering.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <20220809223308.1421081-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJR9mRo8g+8zegvuCHs7ySCxf8PYuhO/Jxb2xDaKH2BkAUnRquhOLnxE1RiShibTz88BwOQlFDpef1fpkFvGB9kmOQYOdEkumdhGKkQmqkdBWOAc4DT5
 roLiOyslBMi7W8/fiEx2p/FKDljWIeBHRmttcv9trJwK6LkG6UJPTCKmE04Fa/TkNEydfYOLNjEB4k2CZAZtBe+kuHsjuJ714DbrYeBFbRt60WABqZJpaO46
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi All,

please drop this patch in favor of upcoming V3. This is not a good way
to use pkg-config with Autotools.

Sorry for the noise

Best regards
-- 
Giulio Benetti
Benetti Engineering sas

On 10/08/22 00:33, Giulio Benetti wrote:
> -lmount must preceed -lblkid and to obtain this let's add:
> `pkg-config --libs mount`
> in place of:
> `-lmount`
> This ways the library order will always be correct.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
> V1->V2:
> * modify pkg-conf to pkg-config
> ---
>   tools/nfsrahead/Makefile.am | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/nfsrahead/Makefile.am b/tools/nfsrahead/Makefile.am
> index 845ea0d5..280a2eb4 100644
> --- a/tools/nfsrahead/Makefile.am
> +++ b/tools/nfsrahead/Makefile.am
> @@ -1,6 +1,6 @@
>   libexec_PROGRAMS = nfsrahead
>   nfsrahead_SOURCES = main.c
> -nfsrahead_LDFLAGS= -lmount
> +nfsrahead_LDFLAGS= `pkg-config --libs mount`
>   nfsrahead_LDADD = ../../support/nfs/libnfsconf.la
>   
>   man5_MANS = nfsrahead.man

