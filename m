Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ED44E2EC3
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Mar 2022 18:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351603AbiCURIS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 13:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351623AbiCURIS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 13:08:18 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C6418B7AB
        for <linux-nfs@vger.kernel.org>; Mon, 21 Mar 2022 10:06:50 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id s16so12143761qks.4
        for <linux-nfs@vger.kernel.org>; Mon, 21 Mar 2022 10:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6FGD/WTuSIXmXT8ilaO/tBWCW54t7GMsXJrFT0wFB5w=;
        b=Ce9IO5p6vwA9+4KNE95Bo2OBGu6266pSILvy91duIFKgR9s/J4HX0cgECSb6vrJX/J
         SfsaetiNoMS4XPYvx22v1YU2Pt3pW9C0Ic3JYxKBvCjo7XmWIOHEEAAUSduTK3oMevt0
         YChMJKZ3Zwo+zFgCFAwp/WLyqH1qdMC21835KI7CHgHk0d5bY1kJChjBZU7FhMsl/4S3
         iS+EY898TvupT/OX6wQEpn+ONSrZ6V59LaskI/N6BiXhlLYiiy5I92g/SOgqkg5wiB5Z
         gceHIuWV6PE4Oou9NBWAMotfP+JyAXzXWwi6QqTKI3kn0IfJ40IHrfWFWTakHNBBLT/S
         hBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6FGD/WTuSIXmXT8ilaO/tBWCW54t7GMsXJrFT0wFB5w=;
        b=7WnQiem7lcTIfhxmuFkUd2qoCEwWMRfYLN7flCkApa0ustv1z99s0noxIAIkqwRhGf
         UlrN3VG2al/nhKDN9UeQYgyoPckr1ApQnwKAj1eaxdQqtfVfKf39bmMpoSMeQKGY6jAb
         0kFqY8BBl3/cDdHhUkTahuylwZiSmm+G/VdNbgyHskPWsFPNvt9GQWs9SrtylfM4gBXq
         IS/Q4QuHcC8iuM6jwwAggUCotwixOLBe7jIQ+0YH/bzPn/PBdJqB72Ha4Qt1xuIQITYL
         iDoJLmvH7HxsgXIEp19L6b+iPkkU/8JNOzE/OAfCUnB1iixEL5QXzdiqB3G3WibQTVwg
         w+Dw==
X-Gm-Message-State: AOAM533n8GWq/11xfLDyXaKrx2eBRQUobjCKneY8Km3ZSAirgdPUokgQ
        fmScs5MUlaLoeGeLZrWQ0B6Rnih0x3B+A/55ewa4hg==
X-Google-Smtp-Source: ABdhPJxfIEtzC31bQBsGSWiCw75gZY0zguDBuHbBV5ngG04N1tb0Sk7JP/pOuiBR5tUm41ZdJNfnHSWte0B7Lodye3c=
X-Received: by 2002:a05:620a:166b:b0:67b:1333:4df1 with SMTP id
 d11-20020a05620a166b00b0067b13334df1mr13097350qko.423.1647882408736; Mon, 21
 Mar 2022 10:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220319001635.4097742-1-khazhy@google.com> <ea2afc67b92f33dbf406c3ebf49a0da9c6ec1e5b.camel@hammerspace.com>
 <CAOQ4uxgTJdcO-xZbtTSUkjD2g0vSHr=PLFc6-T6RgO0u5DS=0g@mail.gmail.com>
In-Reply-To: <CAOQ4uxgTJdcO-xZbtTSUkjD2g0vSHr=PLFc6-T6RgO0u5DS=0g@mail.gmail.com>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Mon, 21 Mar 2022 10:06:37 -0700
Message-ID: <CACGdZY+wHLFXt5i22Y+j3QFddTJiUXy9WfbLDB=CjrvTsTK9ug@mail.gmail.com>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>, Jan Kara <jack@suse.cz>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a4abfe05dabd8590"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--000000000000a4abfe05dabd8590
Content-Type: text/plain; charset="UTF-8"

On Sat, Mar 19, 2022 at 2:36 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sat, Mar 19, 2022 at 9:02 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > On Fri, 2022-03-18 at 17:16 -0700, Khazhismel Kumykov wrote:
> > > fsnotify_add_inode_mark may allocate with GFP_KERNEL, which may
> > > result
> > > in recursing back into nfsd, resulting in deadlock. See below stack.
> > >
> > > nfsd            D    0 1591536      2 0x80004080
> > > Call Trace:
> > >  __schedule+0x497/0x630
> > >  schedule+0x67/0x90
> > >  schedule_preempt_disabled+0xe/0x10
> > >  __mutex_lock+0x347/0x4b0
> > >  fsnotify_destroy_mark+0x22/0xa0
> > >  nfsd_file_free+0x79/0xd0 [nfsd]
> > >  nfsd_file_put_noref+0x7c/0x90 [nfsd]
> > >  nfsd_file_lru_dispose+0x6d/0xa0 [nfsd]
> > >  nfsd_file_lru_scan+0x57/0x80 [nfsd]
> > >  do_shrink_slab+0x1f2/0x330
> > >  shrink_slab+0x244/0x2f0
> > >  shrink_node+0xd7/0x490
> > >  do_try_to_free_pages+0x12f/0x3b0
> > >  try_to_free_pages+0x43f/0x540
> > >  __alloc_pages_slowpath+0x6ab/0x11c0
> > >  __alloc_pages_nodemask+0x274/0x2c0
> > >  alloc_slab_page+0x32/0x2e0
> > >  new_slab+0xa6/0x8b0
> > >  ___slab_alloc+0x34b/0x520
> > >  kmem_cache_alloc+0x1c4/0x250
> > >  fsnotify_add_mark_locked+0x18d/0x4c0
> > >  fsnotify_add_mark+0x48/0x70
> > >  nfsd_file_acquire+0x570/0x6f0 [nfsd]
> > >  nfsd_read+0xa7/0x1c0 [nfsd]
> > >  nfsd3_proc_read+0xc1/0x110 [nfsd]
> > >  nfsd_dispatch+0xf7/0x240 [nfsd]
> > >  svc_process_common+0x2f4/0x610 [sunrpc]
> > >  svc_process+0xf9/0x110 [sunrpc]
> > >  nfsd+0x10e/0x180 [nfsd]
> > >  kthread+0x130/0x140
> > >  ret_from_fork+0x35/0x40
> > >
> > > Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> > > ---
> > >  fs/nfsd/filecache.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > Marking this RFC since I haven't actually had a chance to test this,
> > > we
> > > we're seeing this deadlock for some customers.
> > >
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index fdf89fcf1a0c..a14760f9b486 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -121,6 +121,7 @@ nfsd_file_mark_find_or_create(struct nfsd_file
> > > *nf)
> > >         struct fsnotify_mark    *mark;
> > >         struct nfsd_file_mark   *nfm = NULL, *new;
> > >         struct inode *inode = nf->nf_inode;
> > > +       unsigned int pflags;
> > >
> > >         do {
> > >                 mutex_lock(&nfsd_file_fsnotify_group->mark_mutex);
> > > @@ -149,7 +150,10 @@ nfsd_file_mark_find_or_create(struct nfsd_file
> > > *nf)
> > >                 new->nfm_mark.mask = FS_ATTRIB|FS_DELETE_SELF;
> > >                 refcount_set(&new->nfm_ref, 1);
> > >
> > > +               /* fsnotify allocates, avoid recursion back into nfsd
> > > */
> > > +               pflags = memalloc_nofs_save();
> > >                 err = fsnotify_add_inode_mark(&new->nfm_mark, inode,
> > > 0);
> > > +               memalloc_nofs_restore(pflags);
> > >
> > >                 /*
> > >                  * If the add was successful, then return the object.
> >
> > Isn't that stack trace showing a slab direct reclaim, and not a
> > filesystem writeback situation?
> >
> > Does memalloc_nofs_save()/restore() really fix this problem? It seems
> > to me that it cannot, particularly since knfsd is not a filesystem, and
> > so does not ever handle writeback of dirty pages.
> >
>
> Maybe NOFS throttles direct reclaims to the point that the problem is
> harder to hit?

(I think I simply got confused - I don't see reason that NOFS would
help with direct reclaim, though it does look like the gfp flags are
passed via a shrink_control struct so one *could* react to them in the
shrinker - again not an area i'm super familiar with)

>
> This report came in at good timing for me.
>
> It demonstrates an issue I did not predict for "volatile"' fanotify marks [1].
> As far as I can tell, nfsd filecache is currently the only fsnotify backend that
> frees fsnotify marks in memory shrinker. "volatile" fanotify marks would also
> be evictable in that way, so they would expose fanotify to this deadlock.
>
> For the short term, maybe nfsd filecache can avoid the problem by checking
> mutex_is_locked(&nfsd_file_fsnotify_group->mark_mutex) and abort the
> shrinker. I wonder if there is a place for a helper mutex_is_locked_by_me()?

fwiw, it does look like ~5.5 nfsd did stop freeing fanotify marks
during reclaim, in the commit "nfsd: Containerise filecache
laundrette" (I had sent an earlier email about this, not sure where
that's getting caught up, but I do see it on lore...)


>
> Jan,
>
> A relatively simple fix would be to allocate fsnotify_mark_connector in
> fsnotify_add_mark() and free it, if a connector already exists for the object.
> I don't think there is a good reason to optimize away this allocation
> for the case of a non-first group to set a mark on an object?
>
> Thanks,
> Amir.
>
>
>
> [1] https://lore.kernel.org/linux-fsdevel/20220307155741.1352405-1-amir73il@gmail.com/

--000000000000a4abfe05dabd8590
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmwYJKoZIhvcNAQcCoIIPjDCCD4gCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz1MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
h3dPtFviTyG11HYwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYIKwYBBQUH
AQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRs
YXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29t
L2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvR
zV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBAE0ANr7NUOqEcZce4KYP
SjzlrshSC8sgJ8dKDDbe35PL86vDuMIrytVjiV10p/YUofun9GeHBY6r5kTyh4be5FgftiiNtWzn
U1W5cxLYMT1hKYxXxnM2sWMQGFl4TkxxbRoVZa3ou/NxFdAZeiQSwGnzk5oIDTBZQc8q3wMa1svm
A5Rd4MVaIUt+hyk6seAldN6k4/O34O1l2V6D+/BwagyzLWvOeMEM9hClVF+F6a20yy4dcDsprFZZ
Sk9JzUy9F6FM7L1wT2ndjTNDja4Y2tixf31KuisZLGKmDZsW/fXF1GgWDaM0DbYJwtE3kHylWnMk
CN4PfYgIa15C5A9lXhExggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjAC
EAFEftjde/YEIFcjUXqhcBUwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILJDQRfl
nWE4ibkfLLaobYYE11pMahEOtkni96yvUG5jMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIyMDMyMTE3MDY0OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBSZUpkVRqZ9ITkRc7aXg9ajMHQ
jF3zkENPHHDFuLh9SGmTEW5B5TxqRWpypMUqASOXD1KUXD5Ut8dbvZaIyb3txY66szKXTK8pzUX9
0amuXvjBdu+HIJTTCACE8Ylo6Whm++80vrcszgugin0yorYmwZ7NdrCiLTlc4ivG6Zb9svB6ltzu
t3FEhw3w1XUDDBBHYYUBQvyVtM1RVR94olaLFdOkmtwfoPNqRXYE0107PDNi8+WNuU8zMyBzgSsi
idaiIFMkL6AWROO+P/zg6L/IcGt7atGIkB1uRcs+Uvfg89TWDUjpw49PIjISdldUa9HmdkiNozlE
dbPdY7yoaQ6J
--000000000000a4abfe05dabd8590--
