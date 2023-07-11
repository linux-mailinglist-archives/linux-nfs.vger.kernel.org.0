Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFC574EBE5
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 12:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjGKKof (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jul 2023 06:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjGKKoe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jul 2023 06:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68CAE60
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 03:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689072224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g6Awne55tuWvMLFnJVeV7sFCFQMzfgeVqq3DwkIUAv8=;
        b=SUW2c37nty7W6UOKAf99GiuXwa5CtLhBsG70hruNrOkp6D+S3mQs6WHFlUhX8W8U1v0r8k
        TYRdbF1r+SO4lQ+mOip5nLAwklJ6iNhw3vLPNzOQbLK2AduwYlGaDWK2bkTDi7H5ad4kV/
        hEfx7LDuoMGC/xdSdzc+9yM3UgAktR4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-NO_WbI_1M6eHa2TqX6z2ew-1; Tue, 11 Jul 2023 06:43:43 -0400
X-MC-Unique: NO_WbI_1M6eHa2TqX6z2ew-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76746f54ba9so706172985a.0
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 03:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689072222; x=1691664222;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6Awne55tuWvMLFnJVeV7sFCFQMzfgeVqq3DwkIUAv8=;
        b=YBf67mQqE95qp+mRbgtcTHlvHkIYtFzRT8IPgU0Sk6Sqm+Rq0XzjvhNZftHzo1rKNO
         4u3ei2wWDlLQj1kfkrL4ztGbWXLGW43PAzHZ6TyYJkb7LZzJueXYhOWGwC1c0LQ+RQ7T
         GKKJj0/jeDnF8yTnB1pH+h8khc5JWmDf77JfYs5tLhe5M4FMWooaXsyO8tR768ukyjdD
         1TTzPUebfAH8hq8Ymr6MSF8n83LkX4SP+Ovh2GgLyJkrn8hXbYnEzfxSXYnmohvZXknS
         h0IFtPEXjcQQGncN0qjefBdU7ttg0BE5EJ+0tzFHEEhLPn/6JGsu+o+hxGgONIQAIzt6
         gveQ==
X-Gm-Message-State: ABy/qLani9OQf8zxZUjCiRDgznekW9HPog1H8HQV+XLPT6ETou7IGX2q
        I8AIzZBmph2MN47j/SG3K6WUqnnxF2ojV/55BxVtyFVbupX0s1qHHoa/K9vBSOhN2XQlBxYaEZN
        rkeV5zg4YO+8i+Xr6zBOW
X-Received: by 2002:a05:620a:2b0f:b0:765:a95a:571b with SMTP id do15-20020a05620a2b0f00b00765a95a571bmr14615784qkb.41.1689072222488;
        Tue, 11 Jul 2023 03:43:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF8F9EySgOHEPKlLIFFzVTSyT9rgPMgceST/NSvHUBTYYNaALl0KboELfRLWP2FzWZIdUojJw==
X-Received: by 2002:a05:620a:2b0f:b0:765:a95a:571b with SMTP id do15-20020a05620a2b0f00b00765a95a571bmr14615777qkb.41.1689072222193;
        Tue, 11 Jul 2023 03:43:42 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id o7-20020a05620a15c700b00767e2479801sm368275qkm.2.2023.07.11.03.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 03:43:41 -0700 (PDT)
Message-ID: <79125af67939f5ef8c03c313a346711b768717d9.camel@redhat.com>
Subject: Re: [PATCH/RFC] sunrpc: constant-time code to wake idle thread
From:   Jeff Layton <jlayton@redhat.com>
To:     NeilBrown <neilb@suse.de>, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>
Date:   Tue, 11 Jul 2023 06:43:40 -0400
In-Reply-To: <168906970156.8939.2877716074642019289@noble.neil.brown.name>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
        , <168842927591.139194.16920372497489479670.stgit@manet.1015granger.net>
        , <168843152047.8939.5788535164524204707@noble.neil.brown.name>
        , <ZKN6GZ8q9NVLywOJ@manet.1015granger.net>
        , <168894969894.8939.6993305724636717703@noble.neil.brown.name>
        , <ZKwYhbo76v8ElI1b@manet.1015granger.net>
        , <168902749573.8939.3668770103738816387@noble.neil.brown.name>
        , <2211CC3B-806F-461D-A5AA-E95E35E1E408@oracle.com>
         <168906970156.8939.2877716074642019289@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-07-11 at 20:01 +1000, NeilBrown wrote:
> On Tue, 11 Jul 2023, Chuck Lever III wrote:
> > > On Jul 10, 2023, at 6:18 PM, NeilBrown <neilb@suse.de> wrote:
> > >=20
> > > What do you think of removing the ability to stop an nfsd thread by
> > > sending it a signal.  Note that this doesn't apply to lockd or to nfs=
v4
> > > callback threads.  And nfs-utils never relies on this.
> > > I'm keen.  It would make this patch a lot simpler.
> >=20
> > I agree the code base would be cleaner for it.
> >=20
> > But I'm the new kid. I'm not really sure if this is
> > part of a kernel - user space API that we mustn't
> > alter, or whether it's something that was added but
> > never used, or ....
> >=20
> > I can sniff around to get a better understanding.
>=20
> Once upon a time it was the only way to kill the threads.
> There was a syscall which let you start some threads.  You couldn't
> change the number of threads, but you could kill them.
> And shutdown always kills processes, so letting nfsd threads be killed
> meant that would be removed at system shutdown.
>=20
> When I added the ability to dynamically change the number of threads it
> made sense that we could set the number to zero, and then to use that
> functionality to shut down the nfs server.  So the /etc/init.d/nfsd
> script changed from "killall -9 nfsd" or whatever it was to=20
> "rpc.nfsd 0".
>=20
> But it didn't seem sensible to remove the "kill" functionality until
> after a transition process, and I never thought the schedule a formal
> deprecation.  So it just stayed...
>=20
> The more I think about it, the more I am in favour of removing it.  I
> don't think any other kernel threads can be killed.  nfsd doesn't need
> to be special.
>=20
> Maybe I'll post a patch which just does that.
>=20

I'd be in favor of removing signal handling from the nfsd threads. It's
always been a bit hacky, particularly since we moved everything to the
kthread API around a decade ago.

--=20
Jeff Layton <jlayton@redhat.com>

