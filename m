Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8CA7EE91D
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 23:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjKPWMF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 17:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPWME (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 17:12:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57C1C2
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 14:12:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49305C433C9
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 22:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700172721;
        bh=9aleZyF0iTrYiJ823tyao5aNujoTALco2yf5RgRTFnA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BcsnzfloH6WFMw65XjUrwXdpDFLnh6S4o2fR5XP7Bc9u0LiuWQzEJbSg96vZWpVjO
         T5OnD5sD/migtzH6mD/YXMa3KqsgIN3pVOCuCoh5iTUc8VIob0V43W2qanvNrzWyFM
         eI1l63jsYUf6oWYv3oKB9vMB//e7gJXjpoDV28z+f6Hf1SdpJVrlC2zfzrQNIW/RM9
         XUGMH4SkAGEme0peasp7OlkTEP9CF/Zqt/ZufMAXarqm5OU37FnOqCB0qoZIx3uetz
         NipRPhZq9XdwOmWHqhT09EpnX9NqTd7LOZnNXrLikfll9upqYLepqaRkDxowvzhXc8
         h4lEnErSRCxjw==
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-77ba6d5123fso215444885a.0
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 14:12:01 -0800 (PST)
X-Gm-Message-State: AOJu0Yx7BAMVLQDNk88wfuyZizbB/zTsABopwkpQ/5uaiF47uX/3pp+A
        Csppp4sr36TwmGJylgLWcsdKG5dHZUUsikBogo0=
X-Google-Smtp-Source: AGHT+IGb+jyyVwDo/KnNyXjYaY23wCqgMjjOaKQI6WqVNdX+rYDOAcY/5tVr0ZoOJP6D1eO8+JG729KeA3pPx3qLvIE=
X-Received: by 2002:a05:620a:1729:b0:778:9813:6cad with SMTP id
 az41-20020a05620a172900b0077898136cadmr4310103qkb.4.1700172720525; Thu, 16
 Nov 2023 14:12:00 -0800 (PST)
MIME-Version: 1.0
References: <21a1f2a6155398965f79ed64f0bd23bf38a50367.1700083991.git.bcodding@redhat.com>
 <952eea7e97246870f83e7a4592e9338007dfe625.1700083991.git.bcodding@redhat.com>
 <CAFX2Jfkc7p+22aK0KvN4yUerS1HuKDC+Njo_AJV1=5pWW0sUYQ@mail.gmail.com> <CCFAA747-7BC9-40AB-8E37-A18B33A01511@redhat.com>
In-Reply-To: <CCFAA747-7BC9-40AB-8E37-A18B33A01511@redhat.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Thu, 16 Nov 2023 17:11:44 -0500
X-Gmail-Original-Message-ID: <CAFX2Jf=bDFEx2cfzXtHhaMu0pF5dV1-sheANmAXMf0m-arr61w@mail.gmail.com>
Message-ID: <CAFX2Jf=bDFEx2cfzXtHhaMu0pF5dV1-sheANmAXMf0m-arr61w@mail.gmail.com>
Subject: Re: [PATCH 2/2] NFS: drop unused nfs_direct_req bytes_left
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 16, 2023 at 5:03=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 16 Nov 2023, at 16:44, Anna Schumaker wrote:
>
> > Hi Ben,
> >
> > On Wed, Nov 15, 2023 at 4:34=E2=80=AFPM Benjamin Coddington <bcodding@r=
edhat.com> wrote:
> >>
> >> Now that we're calculating how large a remaining IO should be based
> >> on the current request's offset, we no longer need to track bytes_left=
 on
> >> each struct nfs_direct_req.  Drop the field, and clean up the direct
> >> request tracepoints.
> >
> > I've been having problems with xfstests generic/465 on all NFS
> > versions after applying this patch. Looking at wireshark, the client
> > appears to be resending the same reads over and over again. Have you
> > seen anything like this in your testing?
>
> I have generic/465 failing before and after these two patches on pNFS SCS=
I..
> but at least it completes.  If I run it without pNFS I can see the same
> thing.. it just sends the same reads over and over.  I'll figure out why.

Thanks! I have it failing normally as well, so that's expected. It's
the hanging forever that's not :)

Anna

>
> Ben
>
