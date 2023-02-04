Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1B668A72C
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Feb 2023 01:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjBDAP2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Feb 2023 19:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjBDAP0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Feb 2023 19:15:26 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0864B841AA
        for <linux-nfs@vger.kernel.org>; Fri,  3 Feb 2023 16:15:23 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id cr22so7431954qtb.10
        for <linux-nfs@vger.kernel.org>; Fri, 03 Feb 2023 16:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tLvgzQ6dsm7c3CxDiJ8sVQVrQNgfP4ZUUMr823rYDdA=;
        b=L0dKb43gEDkR8b1T/n8eSe7RnwJJV1gxXLWT7wD0Ns1fw40LDrJ9s6RCRAW91ir5yo
         /tVhgfJLGvrpXJ4MsBChDztNuwULjKCFh3HcklYvRhhJjYpVCg2Gy/YrTInCFwcyqaVq
         pgL7Gjb5BMOtRVgcgrEnnzXohAL9prdEzBYf7kzWPHAt9RW23CvCj4+DE7uzeWGEv/sY
         +IdlFXbUNBP07Eo/yAzoYg5w2lKDiQzGd7BycdK1qpXncSMzD8htJ46Rb6TQylY7FEH0
         EbVuj65Is8ZQDzki7QdTLRxbjzwXSCwt3tFetHFzHkq/gyD26VYfuasDlYBmg+LJjdM+
         Fy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLvgzQ6dsm7c3CxDiJ8sVQVrQNgfP4ZUUMr823rYDdA=;
        b=kQOUnvW5ldLBOiNFDobddKu7ggVhWYrzEeeJSQqrVqqOc6cWEr7kVvctghs0JWbt3d
         xshhnV5jebtSElQ5dk1aWoyIIpG6FJTU7NzdQwVVyHtZOmtW4dj2APgOOGtYDKoLZ+uO
         Tj9YS/DxF+MC5jYLLz5FkJ4mBWDNWnLFe3Eyq2Eti/hTsIGYhyC2WjBewdooM/yjh0Hh
         lu5xNt5Jdtj7FqlUmJEchXMMOOeJ/PYUfHhi7XNlnMxSAhEqdkzB32hxsAu0cjEyheRs
         uH2Iemj9/+hG9pWitb8ywPr9DpXZl8DfxE26JOYZxtZ9eTT+scmzPq/b4anRtoQ+kApw
         hIBA==
X-Gm-Message-State: AO0yUKVIhBO/Dm1mCd9Q0WAjJ+oBQJyJi7FF96g+ntJCCvEVz6jfA2xw
        nnEdN3N9GmIhTcIIxp4YlqXuhCtbQGg1VZMWtoc=
X-Google-Smtp-Source: AK7set9xKBrVVJh1a839klvip0hWrMQigT2pudAYsUwIgtOx6Y+A4odllEJdFyJjmFbv9G8Ob1GqQg==
X-Received: by 2002:ac8:7e86:0:b0:3b6:425d:d5ca with SMTP id w6-20020ac87e86000000b003b6425dd5camr22136474qtj.24.1675469722019;
        Fri, 03 Feb 2023 16:15:22 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bk42-20020a05620a1a2a00b006fa16fe93bbsm2936402qkb.15.2023.02.03.16.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 16:15:21 -0800 (PST)
Date:   Fri, 3 Feb 2023 16:15:12 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Trond Myklebust <trondmy@hammerspace.com>
cc:     Hugh Dickins <hughd@google.com>,
        Charles Edward Lever <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: git regression failures with v6.2-rc NFS client
In-Reply-To: <0D7A0393-EE80-4785-9A83-44CF8269758B@hammerspace.com>
Message-ID: <ab632691-7e4c-ccbf-99a0-397f1f7d30ec@google.com>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com> <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com> <5FF4061F-108C-4555-A32D-DDBFA80EE4E7@redhat.com> <F1833EA0-263F-46DF-8001-747A871E5757@redhat.com> <B90C62F2-1D3A-40E0-8E33-8C349C6FFD3D@oracle.com>
 <44CB1E86-60E0-4CF0-9FD4-BB7E446542B7@redhat.com> <1AAC6854-2591-4B21-952A-BC58180B4091@oracle.com> <41813D21-95C8-44E3-BB97-1E9C03CE7FE5@redhat.com> <79261B77-35D0-4E36-AA29-C7BF9FB734CC@oracle.com> <104B6879-5223-485F-B099-767F741EB15B@redhat.com>
 <966AEC32-A7C9-4B97-A4F7-098AF6EF0067@oracle.com> <545B5AB7-93A6-496E-924E-AE882BF57B72@hammerspace.com> <FA8392E6-DAFC-4462-BDAE-893955F9E1A4@oracle.com> <4dd32d-9ea3-4330-454a-36f1189d599@google.com>
 <0D7A0393-EE80-4785-9A83-44CF8269758B@hammerspace.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-1720490057-1675469721=:2591"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-1720490057-1675469721=:2591
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 4 Feb 2023, Trond Myklebust wrote:
> > On Feb 3, 2023, at 18:53, Hugh Dickins <hughd@google.com> wrote:
> > On Fri, 3 Feb 2023, Chuck Lever III wrote:
> >>> On Feb 3, 2023, at 5:26 PM, Trond Myklebust <trondmy@hammerspace.com>=
 wrote:
> >>> The bottom line is that you=E2=80=99ve always been playing the lotter=
y when mounting tmpfs over NFS.
> >>=20
> >> I'm not debating the truth of that. I just don't think we should
> >> be making that situation needlessly worse.
> >>=20
> >> And I would be much more comfortable with this if it appeared in
> >> a man page or on our wiki, or ... I'm sorry, but "some email in
> >> 2001" is not documentation a user should be expected to find.
> >=20
> > I very much agree with you, Chuck.  Making something imperfect
> > significantly worse is called "a regression".
> >=20
> > And I would expect the (laudable) optimization which introduced
> > that regression to be reverted from 6.2 for now, unless (I imagine
> > not, but have no clue) it can be easily conditionalized somehow on
> > not-tmpfs or not-simple_dir_operations.  But that's not my call.
> >=20
> > What is the likelihood that simple_dir_operations will be enhanced,
> > or a satisfactory complicated_dir_operations added?  I can assure
> > you, never by me!  If Al or Amir or some dcache-savvy FS folk have
> > time on their hands and an urge to add what's wanted, great: but
> > that surely will not come in 6.2, if ever.
> >=20
> > More likely that effort would have to come from the NFS(D) end,
> > who will see the benefit.  And if there's some little tweak to be
> > made to simple_dir_operations, which will give you the hint you need
> > to handle it better, I expect fsdevel would welcome a patch or two.
> >=20
> > Hugh
>=20
>=20
> No! If it was impossible to hit this problem before the patch, then I mig=
ht agree with you. However what it does is exposes a problem that has alway=
s existed, but was a lot less likely to happen timing wise when we were all=
owing glibc to suck in all 50000 or so directory entries in one gulp.
>=20
> IOW: this patch doesn=E2=80=99t cause the problem, it just makes it easie=
r to hit when you are using a high performance setup like Chuck's. It was a=
lways easy to hit when you were using slower networking and/or smaller rsiz=
e values against a remote server with multiple clients creating + deleting =
files in the same NFS exported tmpfs directory.
> _________________________________
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

I can only repeat,
making something imperfect significantly worse is called "a regression".

Hugh
---1463760895-1720490057-1675469721=:2591--
