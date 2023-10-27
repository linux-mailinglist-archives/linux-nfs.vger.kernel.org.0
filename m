Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237327D8E81
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 08:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjJ0GMM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 02:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0GMM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 02:12:12 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAA51AD;
        Thu, 26 Oct 2023 23:12:09 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-778a20df8c3so133933785a.3;
        Thu, 26 Oct 2023 23:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698387128; x=1698991928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyzP9oefUGUKwnDG9roK/NF6C+odBahbrO/Kipz9AGU=;
        b=bU1o9hhGG5wied9ehfB7iQEfraWisxTNRW9wjbqI4ZPqB5B70z3mPucO85nWbRkAuU
         gvnsHc64vcOgu43szZ53Dha4qESYRjN5VsLRfcdLdLqvNrdPf7uHkODz5gtTlKB32wA3
         Y0fmINPWeKFuCxo//UMwLc/cv8GrKMxO0iVAWjzOlLz7LfycTxUR7ynOGrexMZFVFoJd
         10BIwZD9c+jXALz+BrjOnwNMkXE6l38VWYkEGtkYQr/IeOFUr07loJVKw9D0GJM1FYo6
         ShInuXyCh7IKz80wUc3Qm/1ISt7pCR8F2ozo2G8y9VFqM3pfxCgdhxp/EFdH6xqn/UTy
         8rqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698387128; x=1698991928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyzP9oefUGUKwnDG9roK/NF6C+odBahbrO/Kipz9AGU=;
        b=BE3xtegYhN3MP491iL+ntJpJqvbrLitF5g9mGbYibHUqdkceK0U2JTw1apaYAc6Nf+
         tpwL6pfzGKH7bWFzVsTBAxAW48fmLOdBiLZCmLegUC/jwEjutMpAKIFNarDBj4PTC7zY
         RQMaKiVWlC+SmND50s9OZ77DKotgHchfeqytegRDF0NRdtKFByIgaJoF2S/reLriejRI
         Uaz+0sfQKiBWJ7z4WyxHpdKr+oLjjRnGh8T1A4GBSS+LhBw1Fx/EJNTO7MmFJuDnlg8Y
         krdDNRXoE+Ujy3lSmam6vMNTJ5nUsIpXXsxqeK0pN3pE/Y2edIOK9bNGOJttmsRcSHHg
         qmCg==
X-Gm-Message-State: AOJu0YzqHFdSNcWqxKPfsRClsqCa0A/6IZxIWFJ9ILwwp6f0DBiDjhzC
        qD9uYfIGgEFNuOI4YqheChcHfftVQ6fH7kSmsKI=
X-Google-Smtp-Source: AGHT+IGamK/5mrwijViAH4KVcrP+3u8iXsQPCjW2MTj4dSlLidN8/jAOS0JEQOnGmGme3xd3u/LdR7vzJkLsqZY4j9w=
X-Received: by 2002:a05:6214:2129:b0:66d:9c9f:c913 with SMTP id
 r9-20020a056214212900b0066d9c9fc913mr2888070qvc.1.1698387128671; Thu, 26 Oct
 2023 23:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231026192830.21288-1-rdunlap@infradead.org> <CAOQ4uxhYiu+ou0SiwYsuSd-YayRq+1=zgUw_2G79L8SxkDQV7g@mail.gmail.com>
 <ZTtSJYVmZ/l3d9wD@infradead.org>
In-Reply-To: <ZTtSJYVmZ/l3d9wD@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 27 Oct 2023 09:11:57 +0300
Message-ID: <CAOQ4uxjxTw0k33XqoEUrT6iHdOWrnyMMF=V19ph=HMvqOfC51w@mail.gmail.com>
Subject: Re: [PATCH] exportfs: handle CONFIG_EXPORTFS=m also
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 27, 2023 at 9:01=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Oct 26, 2023 at 10:46:06PM +0300, Amir Goldstein wrote:
> > I would much rather turn EXPORTFS into a bool config
> > and avoid the unneeded build test matrix.
>
> Yes.  Especially given that the defaul on open by handle syscalls
> require it anyway.

Note that those syscalls depend on CONFIG_FHANDLE and the latter
selects EXPORTFS.

Nevertheless, the EXPORTFS=3Dm config seems useless.
I will send a patch to change it.

The bigger issue is that so many of the filesystems that use the
generic export ops do not select EXPORTFS, so it's easier to
leave the generic helper in libfs.c as Arnd suggested.

Thanks,
Amir.
