Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE3B6E9957
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Apr 2023 18:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjDTQR6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Apr 2023 12:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjDTQR4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Apr 2023 12:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D77C2139
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 09:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682007428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xpW87KmDjomF/XnIr+sGvwMjmLo84cGnzstO6sr3FAA=;
        b=Pb6hrb4feIgHjsy2c6GXIgNrVPgR2wUYOUHHlGzeOxvhlAZ2QHUHC8A0/oJeJaZtIJzk6t
        BZHFF6Hoytk9468riKtR+sBcaDU2CrSIZH3zGrYZtegBNw+mkcToFhJ+L348Db1mmsfwKC
        55gQBeVJtQtvTWTAWExckiby/dJfJos=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-EUwYLD7zO3irdEIgSPw6fw-1; Thu, 20 Apr 2023 12:17:07 -0400
X-MC-Unique: EUwYLD7zO3irdEIgSPw6fw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74e1cdf9cbeso364821185a.0
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 09:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682007426; x=1684599426;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpW87KmDjomF/XnIr+sGvwMjmLo84cGnzstO6sr3FAA=;
        b=fzv1u18zMkqJnRb48misYYp/nooFlRQjrsdXtYw0H6UfJGqWP5LPOBEqTSadJze7nV
         1NnsouNSMA8PmZQzFD1J3ZHd4iPl0W6cbHpwt7GxwecXk7djJF+ROi9TDvG2DPN4O3+H
         FrpSeii9oTP2LTSBih5rPxowI1u9vOkfW53vpivE56xeJdqSdOPNxPqaJhq2HudY4uCb
         T0D2itcSjRWOP2ycQB2tOLQLgSULatkdsvgYeNMnS2dYbI69q859R3cpQUD9HT53Xsmy
         Ct8JH64QGeqo0Ur67qrvVDeLy0TGf5VBTdVVTmiFv15oFt0EKN9aIEh1ry4AYKlMkC2h
         iMNw==
X-Gm-Message-State: AAQBX9dNhp0BbZtzwXqxQyrAC2o9d+DKjpMeQ8CVxxQO+LIVF5015Mok
        beXUXO6SdYrjYaSiC3VV0TfTcJkzsjy1JRaUbbzioEVTKSYCC+Q9v2C5vAmGWxXBxnRf8+TRKYR
        yewOQZo4h10z7DaDXUzbbgUOngJG49MEkGzkNJ5ZjAA3uVjr8ux1p2xEIV9rS0kL5k61M70m2Gg
        uNhJc=
X-Received: by 2002:ac8:7f07:0:b0:3db:9289:6949 with SMTP id f7-20020ac87f07000000b003db92896949mr5422110qtk.3.1682007426316;
        Thu, 20 Apr 2023 09:17:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350b10i77sotQOnptkKJ7cSZw1BYnrgnKHDTON0qheXqzSDyYAJ7H+5NiJucFNPeumCOzSTu/1A==
X-Received: by 2002:ac8:7f07:0:b0:3db:9289:6949 with SMTP id f7-20020ac87f07000000b003db92896949mr5422066qtk.3.1682007425929;
        Thu, 20 Apr 2023 09:17:05 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id 78-20020a370651000000b0074e15df0941sm545686qkg.38.2023.04.20.09.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:17:05 -0700 (PDT)
Message-ID: <85ee133945a9f816ffb9612146a6f835c6d443ec.camel@redhat.com>
Subject: Fedora packages for ktls testing available
From:   Jeff Layton <jlayton@redhat.com>
To:     linux-nfs <linux-nfs@vger.kernel.org>,
        kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>
Date:   Thu, 20 Apr 2023 12:17:04 -0400
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I have a Fedora COPR repo set up with the latest RPC with TLS bits from
Chuck:

    https://copr.fedorainfracloud.org/coprs/jlayton/rpctls/

It has a kernel package (currently based on v6.3-rc7), an updated nfs-
utils package (only needed by the NFS server), and a new ktls-utils
package (0.8 based currently) that I'm working to get into the main
Fedora repos after the kernel patches are merged.

My goal is to keep this up to date until the relevant code starts
landing in the main Fedora repos.

Cheers,
--=20
Jeff Layton <jlayton@redhat.com>

