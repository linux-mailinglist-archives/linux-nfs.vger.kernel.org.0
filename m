Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48D8570A2C
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 20:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiGKS4q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 14:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiGKS4p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 14:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC6DB28700
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 11:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657565803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VhPkyw6JSqRXpaTvoZTUIcUz3k2QZrwRVRcGZdJSN50=;
        b=cX0oMQTn0DVw6I3DTTd9mHEenu4hqwWNLhF0NbdSocGbrRr8ARsVg8yIGMPtM+hGHGn6jF
        d/2QHVIqbhPwdnsfXBB6V4vuslGhjNNCiXmN5oPuDT22y1jWlGuX9sK439Nj9g39TAfyvu
        6LOPtzStg85Fy2iiIb8etnn3btR3G/8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-MhU8J9E3OQqvCVjRtEXkHA-1; Mon, 11 Jul 2022 14:56:42 -0400
X-MC-Unique: MhU8J9E3OQqvCVjRtEXkHA-1
Received: by mail-qk1-f200.google.com with SMTP id bm2-20020a05620a198200b006a5dac37fa2so5993197qkb.16
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 11:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=VhPkyw6JSqRXpaTvoZTUIcUz3k2QZrwRVRcGZdJSN50=;
        b=ma6cfktNo2wT0OEfzcBJjxEJhFSRO55TXXpbqX1gn5i0gUx7mEpYNpp8GB7cjCK4VL
         crLlW4S6HoT8KzN4g2ujfIl7jwSIK1beFrn2Ds9sSbE2yL+tloGoekSw75VUbzx6ycjJ
         CwcZrOX3vL94hfdpK/8RMR4D6uDjsvtKy5j/MLi/lNAb8pBk5Gv712RKZKyq1DUEFtyT
         1KBZhx0GaaS6qc1UfwyMqPJX4zXhqaKQHpD6O0cTvzAWTvj1ewCiNCWwjsP50xAVIb3s
         MCe4x5uP5oJtB+ar7bxm2DREtZIADemOVOu8S0FFbdmIxuiXPuCjmQdd7dqCQNVxggGj
         gv6Q==
X-Gm-Message-State: AJIora8/SHiaZIz3rpa7VGiI/E7MWXrdZ4veSms4vRYS37JPt2rZEB24
        nXEczzgLiFHiQbi6pBjr3DPuhe55Ut6vsrmYPSnsVMM+AHcgoCQiLIubD0vTrGzVdxmYiACu9kl
        sVZwtqkiJ7YxVMqdNuiQ+
X-Received: by 2002:a05:620a:28c5:b0:6b2:5245:2901 with SMTP id l5-20020a05620a28c500b006b252452901mr12198434qkp.284.1657565802074;
        Mon, 11 Jul 2022 11:56:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sbSnRL60Jwlg+CU4cgZnQiyj8dGPJzJr8nt0p4zQKZwFhARbZu4qXb2WCEHOrDI/LnVmA0gw==
X-Received: by 2002:a05:620a:28c5:b0:6b2:5245:2901 with SMTP id l5-20020a05620a28c500b006b252452901mr12198424qkp.284.1657565801839;
        Mon, 11 Jul 2022 11:56:41 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id cb25-20020a05622a1f9900b0031b7441b02asm5846436qtb.89.2022.07.11.11.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 11:56:41 -0700 (PDT)
Message-ID: <f5d20f4e1aeb5d478e10a39c17ed003616c7872c.camel@redhat.com>
Subject: Re: [GIT PULL] nfsd changes for 5.18
From:   Jeff Layton <jlayton@redhat.com>
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Igor Mammedov <imammedo@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jul 2022 14:56:40 -0400
In-Reply-To: <20220711183603.GD14184@fieldses.org>
References: <EF97E1F5-B70F-4F9F-AC6D-7B48336AE3E5@oracle.com>
         <20220710124344.36dfd857@redhat.com>
         <B62B3A57-A8F7-478B-BBAB-785D0C2EE51C@oracle.com>
         <5268baed1650b4cba32978ad32d14a5ef00539f2.camel@redhat.com>
         <20220711181941.GC14184@fieldses.org>
         <7CD95BBD-3552-47BD-ACF6-EC51F62787E1@oracle.com>
         <20220711183603.GD14184@fieldses.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-07-11 at 14:36 -0400, Bruce Fields wrote:
> On Mon, Jul 11, 2022 at 06:24:01PM +0000, Chuck Lever III wrote:
> >=20
> >=20
> > > On Jul 11, 2022, at 2:19 PM, Bruce Fields <bfields@fieldses.org> wrot=
e:
> > >=20
> > > On Mon, Jul 11, 2022 at 06:33:04AM -0400, Jeff Layton wrote:
> > > > On Sun, 2022-07-10 at 16:42 +0000, Chuck Lever III wrote:
> > > > > > This patch regressed clients that support TIME_CREATE attribute=
.
> > > > > > Starting with this patch client might think that server support=
s
> > > > > > TIME_CREATE and start sending this attribute in its requests.
> > > > >=20
> > > > > Indeed, e377a3e698fb ("nfsd: Add support for the birth time
> > > > > attribute") does not include a change to nfsd4_decode_fattr4()
> > > > > that decodes the birth time attribute.
> > > > >=20
> > > > > I don't immediately see another storage protocol stack in our
> > > > > kernel that supports a client setting the birth time, so NFSD
> > > > > might have to ignore the client-provided value.
> > > > >=20
> > > >=20
> > > > Cephfs allows this. My thinking at the time that I implemented it w=
as
> > > > that it should be settable for backup purposes, but this was possib=
ly a
> > > > mistake. On most filesystems, the btime seems to be equivalent to i=
node
> > > > creation time and is read-only.
> > >=20
> > > So supporting it as read-only seems reasonable.
> > >=20
> > > Clearly, failing to decode the setattr attempt isn't the right way to=
 do
> > > that.  I'm not sure what exactly it should be doing--some kind of
> > > permission error on any setattr containing TIME_CREATE?
> >=20
> > I don't think that will work.
> >=20
> > NFSD now asserts FATTR4_WORD1_TIME_CREATE when clients ask for
> > the mask of attributes it supports. That means the server has
> > to process GETATTR and SETATTR (and OPEN) operations that
> > contain FATTR4_WORD1_TIME_CREATE as not an error.
>=20
> Well, permissions or bad attribute values or other stuff may prevent
> setting one of the attributes.
>=20
> And setattr isn't guaranteed to be atomic, so I don't think you can
> eliminate the possibility that part of it might succeed and part might
> not.
>=20
> But it might be more helpful to fail the whole thing up front if you
> know part of it's going to fail?
>=20

RFC5661 says:

   On either success or failure of the operation, the server will return
   the attrsset bitmask to represent what (if any) attributes were
   successfully set.  The attrsset in the response is a subset of the
   attrmask field of the obj_attributes field in the argument.

...and then later:

   A mask of the attributes actually set is returned by SETATTR in all
   cases.  That mask MUST NOT include attribute bits not requested to be
   set by the client.  If the attribute masks in the request and reply
   are equal, the status field in the reply MUST be NFS4_OK.

So, I think just clearing the bit and returning NFS4_OK should be fine.

If the mask ends up being 0 after clearing the bit though, it might be
reasonable to return something like NFS4ERR_ATTRNOTSUPP. That would be a
bit weird though since we do support it for GETATTR, hence my suggestion
for a NFS4ERR_ATTR_RO.

> > The protocol
> > allows the server to indicate it ignored the time_create value
> > by clearing the FATTR4_WORD1_TIME_CREATE bit in the attribute
> > bitmask it returns in the reply.
>=20
> Yes, I think you also return an error in that case, though.
>=20
> --b.
>=20

--=20
Jeff Layton <jlayton@redhat.com>

