Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D31A5713F8
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 10:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiGLIJL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 04:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbiGLIJG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 04:09:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 089B733A34
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 01:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657613345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+0BHy+TbI5y4QNBf2E9cU8okI6M2ropxuo+9s7xiag=;
        b=GwUe2nNqHznlhkbs55Ugnt/gTKSDfjcQ8GeLGqsqC4et0yyUv9633z/VnAZCuwPg+1Xzvs
        f0gXxbA/AKxMB/wlIu6nPNU6+PEaafD+awrfIrJLg8E47tb43oYAUiz5o5wLsjTq4OForJ
        ODf7iBZsXTaMTfGxhvI5KIU77XsGWn8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-SoU31PyqPk6WzyZl8ROIHw-1; Tue, 12 Jul 2022 04:09:03 -0400
X-MC-Unique: SoU31PyqPk6WzyZl8ROIHw-1
Received: by mail-wm1-f70.google.com with SMTP id bg6-20020a05600c3c8600b003a03d5d19e4so3458698wmb.1
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 01:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+0BHy+TbI5y4QNBf2E9cU8okI6M2ropxuo+9s7xiag=;
        b=wWcF1fCJY6OVKw0vozxMURbJiswbf9YCxb96kU+l1LE25sYDrspR42Xi7zx4cnKIwu
         6vEEPh0IeQI+tFtfJGkF2qehSYLzZM+r+gol4zhMVE3vXzDaPccc4k9DHjztlo9LRs+4
         VBZN/vfU+54P2ie0+6YkTK2MMOJXRBLAxB9DJ8npf6jIIAUwyoiOHdbhFNI+0TBEF1lr
         /HrruNaNL16u6JTmn/GQYuNjil+JnguFJDnZL+rpTo3QanxPVR5Co7I+P3Fu/vnpPuki
         7qaT74UxzMq1DYtfdU9bF1wj4fZVUjxQ9nzX5YCzyoC6oKEn7HmHS7u5SOh4OW8IgL31
         Plog==
X-Gm-Message-State: AJIora/XvS5vjyaYO8LFkGcNGKh62PklO377U542ctgqX8RMcP85Ud58
        T+UaEwduhF/EQ4L7zDj73nDz2qa/4wSIYsHb+x1zdmWXk9hPOkCOgOfmbGCAwmSyp1jabLM9DZ5
        bqZvAFfCmzwuLCtWxXnBR
X-Received: by 2002:a05:600c:3505:b0:3a1:9fbb:4d59 with SMTP id h5-20020a05600c350500b003a19fbb4d59mr2529156wmq.165.1657613342447;
        Tue, 12 Jul 2022 01:09:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tTkRb943UWorlzCwualpK6U+eYPdow11CztHkTzoYVF1hr08+8yS0GIIDqpO6L79uZn6ijpA==
X-Received: by 2002:a05:600c:3505:b0:3a1:9fbb:4d59 with SMTP id h5-20020a05600c350500b003a19fbb4d59mr2529139wmq.165.1657613342237;
        Tue, 12 Jul 2022 01:09:02 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v26-20020a1cf71a000000b003974a00697esm12069129wmh.38.2022.07.12.01.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 01:09:01 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:09:00 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] NFSD: Decode NFSv4 birth time attribute
Message-ID: <20220712100900.1c8b18dc@redhat.com>
In-Reply-To: <A4F0C111-B2EB-4325-AC6A-4A80BD19DA43@oracle.com>
References: <165747876458.1259.8334435718280903102.stgit@bazille.1015granger.net>
        <20220711191447.1046538c@redhat.com>
        <A4F0C111-B2EB-4325-AC6A-4A80BD19DA43@oracle.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 11 Jul 2022 17:18:38 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> > On Jul 11, 2022, at 1:14 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> > On Sun, 10 Jul 2022 14:46:04 -0400
> > Chuck Lever <chuck.lever@oracle.com> wrote:
> >   
> >> NFSD has advertised support for the NFSv4 time_create attribute
> >> since commit e377a3e698fb ("nfsd: Add support for the birth time
> >> attribute").
> >> 
> >> Igor Mammedov reports that Mac OS clients attempt to set the NFSv4
> >> birth time attribute via OPEN(CREATE) and SETATTR if the server
> >> indicates that it supports it, but since the above commit was
> >> merged, those attempts now fail.
> >> 
> >> Table 5 in RFC 8881 lists the time_create attribute as one that can
> >> be both set and retrieved, but the above commit did not add server
> >> support for clients to provide a time_create attribute. IMO that's
> >> a bug in our implementation of the NFSv4 protocol, which this commit
> >> addresses.
> >> 
> >> Whether NFSD silently ignores the new birth time or actually sets it
> >> is another matter. I haven't found another filesystem service in the
> >> Linux kernel that enables users or clients to modify a file's birth
> >> time attribute.
> >> 
> >> This commit reflects my (perhaps incorrect) understanding of whether
> >> Linux users can set a file's birth time. NFSD will now recognize a
> >> time_create attribute but it ignores its value. It clears the
> >> time_create bit in the returned attribute bitmask to indicate that
> >> the value was not used.
> >> 
> >> Reported-by: Igor Mammedov <imammedo@redhat.com>
> >> Fixes: e377a3e698fb ("nfsd: Add support for the birth time attribute")
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>  
> > 
> > Thanks for fixing it,
> > tested 'touch', 'cp', 'tar' within CLI and copying file with Finder
> > 
> > Tested-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Thanks!
> 
> 
> > on tangent:
> > when copying file from Mac (used 'cp') there is a delay ~4sec/file
> > 'cp' does first triggers create then extra open and then setattr
> > which returns
> > SETATTR Status: NFS4ERR_DELAY
> > after which the client stalls for a few seconds before repeating setattr.
> > So question is what makes server unhappy to trigger this error
> > and if it could be fixed on server side.
> > 
> > it seems to affect other methods of copying. So if one extracted
> > an archive with multiple files or copied multiple files, that
> > would be a pain.
> > 
> > With vers=3 copying is 'instant'
> > with linux client and vers=4.0 copying is 'instant' as well but it
> > doesn't use the same call sequence.
> > 
> > PS:
> > it is not regression (I think slowness was there for a long time)  
> 
> A network capture would help diagnose this further, but it
> sounds like it's delegation-related.
yep, there was delegation request/response right after SETATTR failure
possibly prompted by NFS4ERR_DELAY

shall I provide a network capture (I guess pcap file) from test env
I have?

> >> ---
> >> fs/nfsd/nfs4xdr.c | 9 +++++++++
> >> fs/nfsd/nfsd.h | 3 ++-
> >> 2 files changed, 11 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> >> index 61b2aae81abb..2acea7792bb2 100644
> >> --- a/fs/nfsd/nfs4xdr.c
> >> +++ b/fs/nfsd/nfs4xdr.c
> >> @@ -470,6 +470,15 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
> >> 			return nfserr_bad_xdr;
> >> 		}
> >> 	}
> >> +	if (bmval[1] & FATTR4_WORD1_TIME_CREATE) {
> >> +		struct timespec64 ts;
> >> +
> >> +		/* No Linux filesystem supports setting this attribute. */
> >> +		bmval[1] &= ~FATTR4_WORD1_TIME_CREATE;
> >> +		status = nfsd4_decode_nfstime4(argp, &ts);
> >> +		if (status)
> >> +			return status;
> >> +	}
> >> 	if (bmval[1] & FATTR4_WORD1_TIME_MODIFY_SET) {
> >> 		u32 set_it;
> >> 
> >> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> >> index 847b482155ae..9a8b09afc173 100644
> >> --- a/fs/nfsd/nfsd.h
> >> +++ b/fs/nfsd/nfsd.h
> >> @@ -465,7 +465,8 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
> >> 	(FATTR4_WORD0_SIZE | FATTR4_WORD0_ACL)
> >> #define NFSD_WRITEABLE_ATTRS_WORD1 \
> >> 	(FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP \
> >> -	| FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_MODIFY_SET)
> >> +	| FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_CREATE \
> >> +	| FATTR4_WORD1_TIME_MODIFY_SET)
> >> #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
> >> #define MAYBE_FATTR4_WORD2_SECURITY_LABEL \
> >> 	FATTR4_WORD2_SECURITY_LABEL  
> 
> --
> Chuck Lever
> 
> 
> 

