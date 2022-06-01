Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF0D539E5B
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jun 2022 09:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344955AbiFAHg1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jun 2022 03:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345417AbiFAHgZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jun 2022 03:36:25 -0400
X-Greylist: delayed 511 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Jun 2022 00:36:22 PDT
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0F87A80B
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jun 2022 00:36:21 -0700 (PDT)
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [IPv6:2001:638:700:1038::1:a6])
        by smtp-o-3.desy.de (Postfix) with ESMTP id A49BD60A4E
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jun 2022 09:27:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de A49BD60A4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1654068468; bh=Qick2iSfOgu1Y8FDygDE9jagOryKDt2CW1Ho5Bc4Pa0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=1QkzxT6YPl77BBiRAyQsHxDBaM7+fisXatZ9G9VwoJHpzhsrw6DJ1O5PEd03iGEZb
         TCCR0EcKhEhUF37PwCyaxR1PLOMY8m7HIgh35LlV0CM8GmTI0rbQMayM5+2AJwKpTN
         aTje973seJcDpZlS2g5W3sXhvG1TuCK6d8qVes5w=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [131.169.56.131])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id 98CB5A0586;
        Wed,  1 Jun 2022 09:27:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id 632EFC0177;
        Wed,  1 Jun 2022 09:27:48 +0200 (CEST)
Date:   Wed, 1 Jun 2022 09:27:47 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trondmy <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1666242553.16570812.1654068467831.JavaMail.zimbra@desy.de>
In-Reply-To: <CAN-5tyGF56-spgEcwLV2cfw4KnNfO_ru9tRH9i_mMh+wmC+cTg@mail.gmail.com>
References: <20220531134854.63115-1-olga.kornievskaia@gmail.com> <b829962068bf70b5aadcb16fd0265ec64c85f853.camel@hammerspace.com> <CAN-5tyGF56-spgEcwLV2cfw4KnNfO_ru9tRH9i_mMh+wmC+cTg@mail.gmail.com>
Subject: Re: [PATCH] pNFS: fix IO thread starvation problem during
 LAYOUTUNAVAILABLE error
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_16570828_427416030.1654068468342"
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4232)
Thread-Topic: pNFS: fix IO thread starvation problem during LAYOUTUNAVAILABLE error
Thread-Index: KdT2VOZL5uQPiCdQL888a0t44wwVmQ==
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

------=_Part_16570828_427416030.1654068468342
Date: Wed, 1 Jun 2022 09:27:47 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: trondmy <trondmy@hammerspace.com>, 
	Anna Schumaker <anna.schumaker@netapp.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1666242553.16570812.1654068467831.JavaMail.zimbra@desy.de>
In-Reply-To: <CAN-5tyGF56-spgEcwLV2cfw4KnNfO_ru9tRH9i_mMh+wmC+cTg@mail.gmail.com>
References: <20220531134854.63115-1-olga.kornievskaia@gmail.com> <b829962068bf70b5aadcb16fd0265ec64c85f853.camel@hammerspace.com> <CAN-5tyGF56-spgEcwLV2cfw4KnNfO_ru9tRH9i_mMh+wmC+cTg@mail.gmail.com>
Subject: Re: [PATCH] pNFS: fix IO thread starvation problem during
 LAYOUTUNAVAILABLE error
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4232)
Thread-Topic: pNFS: fix IO thread starvation problem during LAYOUTUNAVAILABLE error
Thread-Index: KdT2VOZL5uQPiCdQL888a0t44wwVmQ==

Hi Olga,

----- Original Message -----
> From: "Olga Kornievskaia" <olga.kornievskaia@gmail.com>
> To: "trondmy" <trondmy@hammerspace.com>
> Cc: "Anna Schumaker" <anna.schumaker@netapp.com>, "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Tuesday, 31 May, 2022 18:03:34
> Subject: Re: [PATCH] pNFS: fix IO thread starvation problem during LAYOUTUNAVAILABLE error

> On Tue, May 31, 2022 at 11:00 AM Trond Myklebust
> <trondmy@hammerspace.com> wrote:
>>
>> On Tue, 2022-05-31 at 09:48 -0400, Olga Kornievskaia wrote:
>> > From: Olga Kornievskaia <kolga@netapp.com>
>> >
>> > In recent pnfs testing we've incountered IO thread starvation problem
>> > during the time when the server returns LAYOUTUNAVAILABLE error to
>> > the
>> > client. When that happens each IO request tries to get a new layout
>> > and the pnfs_update_layout() code ensures that only 1 LAYOUTGET
>> > RPC is outstanding, the rest would be waiting. As the thread that
>> > gets
>> > the layout wakes up the waiters only one gets to run and it tends to
>> > be
>> > the latest added to the waiting queue. After receiving
>> > LAYOUTUNAVAILABLE
>> > error the client would fall back to the MDS writes and as those
>> > writes
>> > complete and the new write is issued, those requests are added as
>> > waiters and they get to run before the earliest of the waiters that
>> > was put on the queue originally never gets to run until the
>> > LAYOUTUNAVAILABLE condition resolves itself on the server.
>> >
>> > With the current code, if N IOs arrive asking for a layout, then
>> > there will be N serial LAYOUTGETs that will follow, each would be
>> > getting its own LAYOUTUNAVAILABLE error. Instead, the patch proposes
>> > to apply the error condition to ALL the waiters for the outstanding
>> > LAYOUTGET. Once the error is received, the code would allow all
>> > exiting N IOs fall back to the MDS, but any new arriving IOs would be
>> > then queued up and one them the new IO would trigger a new LAYOUTGET.
>> >
>> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>> > ---
>> >  fs/nfs/pnfs.c | 14 +++++++++++++-
>> >  fs/nfs/pnfs.h |  2 ++
>> >  2 files changed, 15 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
>> > index 68a87be3e6f9..5b7a679e32c8 100644
>> > --- a/fs/nfs/pnfs.c
>> > +++ b/fs/nfs/pnfs.c
>> > @@ -2028,10 +2028,20 @@ pnfs_update_layout(struct inode *ino,
>> >         if ((list_empty(&lo->plh_segs) || !pnfs_layout_is_valid(lo))
>> > &&
>> >             atomic_read(&lo->plh_outstanding) != 0) {
>> >                 spin_unlock(&ino->i_lock);
>> > +               atomic_inc(&lo->plh_waiting);
>> >                 lseg = ERR_PTR(wait_var_event_killable(&lo-
>> > >plh_outstanding,
>> >                                         !atomic_read(&lo-
>> > >plh_outstanding)));
>> > -               if (IS_ERR(lseg))
>> > +               if (IS_ERR(lseg)) {
>> > +                       atomic_dec(&lo->plh_waiting);
>> >                         goto out_put_layout_hdr;
>> > +               }
>> > +               if (test_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags)) {
>> > +                       pnfs_layout_clear_fail_bit(lo,
>> > pnfs_iomode_to_fail_bit(iomode));
>> > +                       lseg = NULL;
>> > +                       if (atomic_dec_and_test(&lo->plh_waiting))
>> > +                               clear_bit(NFS_LAYOUT_DRAIN, &lo-
>> > >plh_flags);
>> > +                       goto out_put_layout_hdr;
>> > +               }
>> >                 pnfs_put_layout_hdr(lo);
>> >                 goto lookup_again;
>> >         }
>> > @@ -2152,6 +2162,8 @@ pnfs_update_layout(struct inode *ino,
>> >                 case -ERECALLCONFLICT:
>> >                 case -EAGAIN:
>> >                         break;
>> > +               case -ENODATA:
>> > +                       set_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags);
>> >                 default:
>> >                         if (!nfs_error_is_fatal(PTR_ERR(lseg))) {
>> >                                 pnfs_layout_clear_fail_bit(lo,
>> > pnfs_iomode_to_fail_bit(iomode));
>> > diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
>> > index 07f11489e4e9..5c07da32320b 100644
>> > --- a/fs/nfs/pnfs.h
>> > +++ b/fs/nfs/pnfs.h
>> > @@ -105,6 +105,7 @@ enum {
>> >         NFS_LAYOUT_FIRST_LAYOUTGET,     /* Serialize first layoutget
>> > */
>> >         NFS_LAYOUT_INODE_FREEING,       /* The inode is being freed
>> > */
>> >         NFS_LAYOUT_HASHED,              /* The layout visible */
>> > +       NFS_LAYOUT_DRAIN,
>> >  };
>> >
>> >  enum layoutdriver_policy_flags {
>> > @@ -196,6 +197,7 @@ struct pnfs_commit_ops {
>> >  struct pnfs_layout_hdr {
>> >         refcount_t              plh_refcount;
>> >         atomic_t                plh_outstanding; /* number of RPCs
>> > out */
>> > +       atomic_t                plh_waiting;
>> >         struct list_head        plh_layouts;   /* other client
>> > layouts */
>> >         struct list_head        plh_bulk_destroy;
>> >         struct list_head        plh_segs;      /* layout segments
>> > list */
>>
>> According to the spec, the correct behaviour for handling
>> NFS4ERR_LAYOUTUNAVAILABLE is to stop trying to do pNFS to the inode,
>> and to fall back to doing I/O through the MDS. The error describes a
>> more or less permanent state of the server being unable to hand out a
>> layout for this file.
>> If the server wanted the clients to retry after a delay, it should be
>> returning NFS4ERR_LAYOUTTRYLATER. We already handle that correctly.
> 
> To clarify, can you confirm that LAYOUTUNAVAILABLE would only turn off
> the inode permanently but for a period of time?
> 
> It looks to me that for the LAYOUTTRYLATER, the client would face the
> same starvation problem in the same situation. I don't see anything
> marking the segment failed for such error? I believe the client
> returns nolayout for that error, falls back to MDS but allows asking
> for the layout for a period of time, having again the queue of waiters

Your assumption doesn't match to our observation. For files that off-line
(DS down or file is on tape) we return LAYOUTTRYLATER. Usually, client keep
re-trying LAYOUTGET until file is available again. We use flexfile layout
as nfs4_file has less predictable behavior. For files that should be served
by MDS we return LAYOUTUNAVAILABLE. Typically, those files are quite small
and served with a single READ request, so I haven't observe repetitive LAYOUTGET
calls.

Best regards,
   Tigran. 

> that gets manipulated as such that favors last added.
> 
> 
>> Currently, what our client does to handle NFS4ERR_LAYOUTUNAVAILABLE is
>> just plain wrong: we just return no layout, and then let the next
>> caller to pnfs_update_layout() immediately try again.
>>
>> My problem with this patch, is that it just falls back to doing I/O
>> through the MDS for the writes that are already queued in
>> pnfs_update_layout(). It perpetuates the current bad behaviour of
>> unnecessary pounding of the server with LAYOUTGET requests that are
>> going to fail with the exact same error.
>>
>> I'd therefore prefer to see us fix the real bug (i.e. the handling of
>> NFS4ERR_LAYOUTUNAVAILABLE) first, and then look at mitigating issues
>> with the queuing. I already have 2 patches to deal with this.
>>
>> --
>> Trond Myklebust
>> Linux NFS client maintainer, Hammerspace
>> trond.myklebust@hammerspace.com
>>

------=_Part_16570828_427416030.1654068468342
Content-Type: application/pkcs7-signature; name=smime.p7s; smime-type=signed-data
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCAMIIF
vzCCBKegAwIBAgIMJENPm+MXSsxZAQzUMA0GCSqGSIb3DQEBCwUAMIGNMQswCQYDVQQGEwJERTFF
MEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hlbiBGb3JzY2h1bmdz
bmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQDDBxERk4tVmVyZWluIEdsb2Jh
bCBJc3N1aW5nIENBMB4XDTIxMDIxMDEyMzEwOVoXDTI0MDIxMDEyMzEwOVowWDELMAkGA1UEBhMC
REUxLjAsBgNVBAoMJURldXRzY2hlcyBFbGVrdHJvbmVuLVN5bmNocm90cm9uIERFU1kxGTAXBgNV
BAMMEFRpZ3JhbiBNa3J0Y2h5YW4wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQClVKHU
er1OiIaoo2MFDgCSzcqRCB8qVjjLJyJwzHWkhKniE6dwY8xHciG0HZFpSQqiRsoakD+BzqINXsqI
CkVck5n7cUJ6cHBOM1r4pzEBcuuozPrT2tAfnHkFFGTZffOXgjmEITfSh6SD+DYeZH4Dt8kPZmnD
mzWMDFDyB67WWcWApVC1nPh29yGgJk18UZ+Ut9a+woaovMZlutMbuvLVt/x5rpycMw0z+J1qeK7J
8F3bKb0o2gg+Mnz9LzpLtJp7E9qJUKOTkZGDua9w9xrlo4XGX9Vn72K5wodu6woahdgNG+sXRcJM
RH3aWgfdznoi1ORLJCfTbdfjSBpclvt/AgMBAAGjggJRMIICTTA+BgNVHSAENzA1MA8GDSsGAQQB
ga0hgiwBAQQwEAYOKwYBBAGBrSGCLAEBBAgwEAYOKwYBBAGBrSGCLAIBBAgwCQYDVR0TBAIwADAO
BgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBQG
1+t/IHSjHSbbu11uU5Iw7JW92zAfBgNVHSMEGDAWgBRrOpiL+fJTidrgrbIyHgkf6Ko7dDAjBgNV
HREEHDAagRh0aWdyYW4ubWtydGNoeWFuQGRlc3kuZGUwgY0GA1UdHwSBhTCBgjA/oD2gO4Y5aHR0
cDovL2NkcDEucGNhLmRmbi5kZS9kZm4tY2EtZ2xvYmFsLWcyL3B1Yi9jcmwvY2FjcmwuY3JsMD+g
PaA7hjlodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2Rmbi1jYS1nbG9iYWwtZzIvcHViL2NybC9jYWNy
bC5jcmwwgdsGCCsGAQUFBwEBBIHOMIHLMDMGCCsGAQUFBzABhidodHRwOi8vb2NzcC5wY2EuZGZu
LmRlL09DU1AtU2VydmVyL09DU1AwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAxLnBjYS5kZm4uZGUv
ZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSQYIKwYBBQUHMAKGPWh0dHA6
Ly9jZHAyLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQw
DQYJKoZIhvcNAQELBQADggEBADaFbcKsjBPbw6aRf5vxlJdehkafMy4JIdduMEGB+IjpBRZGmu0Z
R2FRWNyq0lNRz03holZ8Rew0Ldx58REJmvAEzbwox4LT1wG8gRLEehyasSROajZBFrIHadDja0y4
1JrfqP2umZFE2XWap8pDFpQk4sZOXW1mEamLzFtlgXtCfalmYmbnrq5DnSVKX8LOt5BZvDWin3r4
m5v313d5/l0Qz2IrN6v7qNIyqT4peW90DUJHB1MGN60W2qe+VimWIuLJkQXMOpaUQJUlhkHOnhw8
82g+jWG6kpKBMzIQMMGP0urFlPAia2Iuu2VtCkT7Wr43xyhiVzkZcT6uzR23PLsAADGCApswggKX
AgEBMIGeMIGNMQswCQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVp
bmVzIERldXRzY2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUw
IwYDVQQDDBxERk4tVmVyZWluIEdsb2JhbCBJc3N1aW5nIENBAgwkQ0+b4xdKzFkBDNQwDQYJYIZI
AWUDBAIBBQCggc4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjIw
NjAxMDcyNzQ4WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUA
MC8GCSqGSIb3DQEJBDEiBCBftRfGU4O6S3/JEPeyfNOd+t2sjNzlucCFtX36eJ8mzzA0BgkqhkiG
9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0B
AQsFAASCAQBLf3yw98NXAGTK0ANVvkMfYjBGhqzrUp7va1AWw7EOj1M2FhcfOsRBtaIA22fqKqlm
uFwTAbBapjZ6JlDAlgNfXeqPTJCTATNhS9w6/CwJ+o4sCJFuGYezaAVe8oNQgykLxOcdLgpclc+p
rIZbrGUaMmVrEcqCqwDDbLcj038S5TAa4Tf//55xiRMuSt6VHPcJcUazvEqnZ4eCBXaOilh3hm4x
c2dJfPH5GEg+mXyfOjy9FjP7dhCwOOEZv+tQQUCBMT6DLKRurffMDJd0dFuXV124SmhWy939BxhO
yg/E1mVmZHqS0dXiks8LaPr5P0YRO0U21MOkRj+vQjgMTtgeAAAAAAAA
------=_Part_16570828_427416030.1654068468342--
