Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11B27A2687
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Sep 2023 20:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbjIOSse (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Sep 2023 14:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbjIOSsc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Sep 2023 14:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF50744A1
        for <linux-nfs@vger.kernel.org>; Fri, 15 Sep 2023 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694803339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4SLe61c41MpedLgHIG37zN0xCNARe7YkFYGtI+CaxPE=;
        b=bI0g5tGc4AAOsq8lRnxbNkNT3yJhXkqXZcTReVPgrv49l6tZ8QXP58JeL5TMR3RRT9ehAb
        hq4J8DrlUEZPHGm0NWI42HzmOna1Ls3R86sqSZIN+PPUYtWyhfwNgjcQVB0WkJK7xediZa
        6iV9K+T5nowzz5kxCCxNR4Gn2AI5A7A=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-3n0IUkYjOfadNms_TYhmoQ-1; Fri, 15 Sep 2023 14:42:17 -0400
X-MC-Unique: 3n0IUkYjOfadNms_TYhmoQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-68faf559913so2106943b3a.0
        for <linux-nfs@vger.kernel.org>; Fri, 15 Sep 2023 11:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694803336; x=1695408136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SLe61c41MpedLgHIG37zN0xCNARe7YkFYGtI+CaxPE=;
        b=mQgchJj+lOv6hvxVCIHdmbqnRdGDo3drDxwRrvbj28ax03+BgILQOKgdwX8JCNSpIL
         nEAJxEaoRqSVAnEojNkXrQOkDkvjGeDHzwW5OBON2LT4yfHGqakQxgLeMLz7ycyo+bnX
         e69GeD1/aLqWLXNZXI6rQfVsKknply3v70zFo+NeT3FmjcLag3DaWO9A7PNl8pe3DKJf
         5SRY/DU5YUGVmQ3t45g+qcWDwz1/Y2FWCjOMLm1LdoSy2k1nD2Mjz/0znkyA31w1R7jm
         PIgND8meTk0eRvEFKz9H+5jU8MtFRQkhsMWd8hrOIURYymEAmCnXnGjopchkeputSCuQ
         m5SQ==
X-Gm-Message-State: AOJu0YxRotFxyu134oq5NMBq9+7tUDJeVP81+jmv0lFuevbNiKgES7wg
        VmzymZBp+tR7HC65zDIeecBg2julbXmBrMI+/UUQdxp9J/dk0FwEJlzx1BXqwS6vejQz7B6HPv9
        VOn3T7jhdrcswcxpAYlqJ8JGGvpCYrQAAyN3NoKqSP7nCrLU=
X-Received: by 2002:a05:6a00:3688:b0:68c:59cb:2dd9 with SMTP id dw8-20020a056a00368800b0068c59cb2dd9mr8161780pfb.1.1694803336172;
        Fri, 15 Sep 2023 11:42:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsp8mshIXLfhl4HOnJ8uLrCf4R08I6IsDyJr98/2jTM5xC56JH3cIcZfaMxyjzHSCWMwjOI69+Vf2bgCx5bM8=
X-Received: by 2002:a05:6a00:3688:b0:68c:59cb:2dd9 with SMTP id
 dw8-20020a056a00368800b0068c59cb2dd9mr8161770pfb.1.1694803335918; Fri, 15 Sep
 2023 11:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230608214137.856006-1-dwysocha@redhat.com> <3629819.1694784702@warthog.procyon.org.uk>
In-Reply-To: <3629819.1694784702@warthog.procyon.org.uk>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 15 Sep 2023 14:41:39 -0400
Message-ID: <CALF+zO=Tdp4F+DYN88Uu=7McbnsVs=bf8dX2LwPR-HGLNZ9b2Q@mail.gmail.com>
Subject: Re: [PATCH] netfs: Only call folio_start_fscache() one time for each folio
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 15, 2023 at 9:31=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Okay, this looks reasonable.  Should I apply Jeff's suggestion before I s=
end
> it to Linus?
>
> David
>
I will send a v2 with Jeff's suggestion added, as well as

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2210612

