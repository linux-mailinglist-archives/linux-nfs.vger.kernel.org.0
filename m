Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7412A74ED41
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 13:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGKLvB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jul 2023 07:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjGKLvA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jul 2023 07:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC101720
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 04:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689076203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsJ3imYgOAarYQqOIcB46FDoRhfdSCxC1NK0IVgdBpY=;
        b=iEbR+lcwDlSsSWwb8WVCIq0XCza5zzflZPXtTqyad09gLYsTZy+7jITKj2NBnImV+q3nsH
        RRRtkYBMGncvqsOJ3P7Dre3obYlyoJfyxJnxKBus2ksHDfuywswFf0OLDJNadFPC3+gRZj
        dZALLVn2BB7VRGjXwhbpPuVP6FeD3JE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-oyi4e4pnOTW_zaf0wYxTbQ-1; Tue, 11 Jul 2023 07:50:02 -0400
X-MC-Unique: oyi4e4pnOTW_zaf0wYxTbQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-635eeb952b8so65006156d6.3
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 04:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689076201; x=1691668201;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JsJ3imYgOAarYQqOIcB46FDoRhfdSCxC1NK0IVgdBpY=;
        b=b4c2aebxluzOk4VUUoxZN/IKSd5PpgFvFOP0dmKwCIyjeDZcuLXSXP33cR0CMP2l1O
         pfSKbSZ+Oh+snWwrC+NEcHxdtfOcAd19gC4ZXs+jCYxHnjKpAaccX68K0sr4cbgaSAZK
         LrFvUCGj/RPBEeF5wgaElTWdrRqpqzxjcPMpsWoqVgm9VG8U0V2/I+9lLypJYmwt3SKe
         QHn1D7XzMmYEs7XHpm5Sl2m7O1ure4Mlgfnkk8+ARQa5Syoqo3kjAWQj1oBZ4Vrmj7CZ
         L6xpScPa7wA2oZTzCCDajZsCKL6HXEthPNZVOtNvo5jS5/7kQh7sa8ufw97UtSNOWnfy
         ghLw==
X-Gm-Message-State: ABy/qLa+LnBHOh++vRcoXuW+dVzXPUWvWHn+FcxlHQyLUEHILC/ayY6g
        fX7Tncto6x6O/9SbUXE+w6qwqr4BkndylRVPgmhV4+ADtBTdKHv9l/7suCTa8nbHxVTbG6YvhbE
        R1AmDg3v/i5YXZm0JbBPl
X-Received: by 2002:a0c:cb03:0:b0:628:ed0e:a165 with SMTP id o3-20020a0ccb03000000b00628ed0ea165mr13312141qvk.58.1689076201663;
        Tue, 11 Jul 2023 04:50:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEPGIARYa0dZuqvmJkig9Ecm4+lQHtY56lJJjdnUwrnCfVGqHaT3xjirT7ltDUcoSjfPzfzLA==
X-Received: by 2002:a0c:cb03:0:b0:628:ed0e:a165 with SMTP id o3-20020a0ccb03000000b00628ed0ea165mr13312131qvk.58.1689076201438;
        Tue, 11 Jul 2023 04:50:01 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id s27-20020a0cb31b000000b0062fffa42cc5sm966453qve.79.2023.07.11.04.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 04:50:00 -0700 (PDT)
Message-ID: <e7c547f0ef877c3e1ae7b22ff738990f16c498c6.camel@redhat.com>
Subject: Re: [PATCH/RFC] sunrpc: constant-time code to wake idle thread
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>
Cc:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Date:   Tue, 11 Jul 2023 07:50:00 -0400
In-Reply-To: <B94C13E5-D84F-4BF7-A559-4E701B0AFA6D@oracle.com>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
         <168842927591.139194.16920372497489479670.stgit@manet.1015granger.net>
         <168843152047.8939.5788535164524204707@noble.neil.brown.name>
         <ZKN6GZ8q9NVLywOJ@manet.1015granger.net>
         <168894969894.8939.6993305724636717703@noble.neil.brown.name>
         <ZKwwFNeTw60Wuo+K@manet.1015granger.net>
         <168902752676.8939.10101566412527206148@noble.neil.brown.name>
         <a85a38468bf0af2f5cb38df2e1c20a8baa0bac6b.camel@redhat.com>
         <B94C13E5-D84F-4BF7-A559-4E701B0AFA6D@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-07-10 at 22:43 +0000, Chuck Lever III wrote:
>=20
> > On Jul 10, 2023, at 6:30 PM, Jeff Layton <jlayton@redhat.com> wrote:
> >=20
> > On Tue, 2023-07-11 at 08:18 +1000, NeilBrown wrote:
> > > On Tue, 11 Jul 2023, Chuck Lever wrote:
> > > >=20
> > > > Actually... Lorenzo reminded me that we need to retain a mechanism
> > > > that can iterate through all the threads in a pool. The xarray
> > > > replaces the "all_threads" list in this regard.
> > > >=20
> > >=20
> > > For what purpose?
> > >=20
> >=20
> > He's working on a project to add a rpc status procfile which shows in-
> > flight requests:
> >=20
> >    https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D366
>=20
> Essentially, we want a lightweight mechanism for detecting
> unresponsive nfsd threads.
>=20

...and personally, it would also be nice to have a "nfstop" program or
something that could repeatedly poll this file and display information
about active nfsd threads. I could also see this being useful for admins
who want quick visibility into nfsd's activity, without having to sniff
traffic.
--=20
Jeff Layton <jlayton@redhat.com>

