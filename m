Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B766C6FBF
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Mar 2023 18:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjCWRym (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Mar 2023 13:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCWRyl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Mar 2023 13:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0431722
        for <linux-nfs@vger.kernel.org>; Thu, 23 Mar 2023 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679594033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o/Ve3SkD+lRWYl2DED4fkrSa6jTwcc+soawlwHMu/6g=;
        b=dkHu4Ak0g6GyZhJnxcU2ibsHIkHsHvUQ7kf+CPeP+q4E+vmFLMfUCuJ5epbLOU4jb0EMVM
        50orN8cU+p9WsBgyqOY78GSzxYp3zrHYk7Oo/DW8ZkRBavD1Ghnmz67zXCiiBKJAH/Xw59
        beIJblelBW2PzDS/EoX8mKr8vrC965w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-ENHAPuC2PqKOM3W6P94C-Q-1; Thu, 23 Mar 2023 13:53:50 -0400
X-MC-Unique: ENHAPuC2PqKOM3W6P94C-Q-1
Received: by mail-qv1-f72.google.com with SMTP id g14-20020ad457ae000000b005aab630eb8eso11257832qvx.13
        for <linux-nfs@vger.kernel.org>; Thu, 23 Mar 2023 10:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679594030; x=1682186030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/Ve3SkD+lRWYl2DED4fkrSa6jTwcc+soawlwHMu/6g=;
        b=dCOLwZeSfGCqqxw9q6ijbhcj0Al7DJRBOQEGMt991Nz/tFwliyTbV6h1zCaTwxsluc
         lctv8zglbaey8KBN+RapHLhufptiOkVwq+3aqo7OdXTJuLYS7mS+Cbn4sQXvRozNsnpN
         oeR9kOwf3ihJ2dQ0i7xFKYOb76kCvx7YZyGA7IPqDXvJgygZBfPi1okF1s1aCyyx1Jzj
         b13OdywD+YKFnSHrRSqJvEH4WEDcNWZEvhTPxveC7npd7HJpSuIHjWlzq+DvUgrLnoM6
         IXaFe13SKAHNTY568xK4y4CIQLVouynh2ITYGF4u75HEX09Dkc/P8kntQDJMWtcOLDDx
         Hj+w==
X-Gm-Message-State: AO0yUKXC1joknMzdkQnM8LepFftxSWh45FBsof2+QT++0HQazbvRI4GB
        FHap+5XoyrXb6/iX0ZG8ljjawHgxLDVM0zGw8S+EVmIQq6iysZ7jCaUOUIrGzayyY6KU2Dudej2
        Ils3W4K0VSFjSYLmHc3EU
X-Received: by 2002:ac8:7c48:0:b0:3b8:36f8:830e with SMTP id o8-20020ac87c48000000b003b836f8830emr348198qtv.6.1679594030193;
        Thu, 23 Mar 2023 10:53:50 -0700 (PDT)
X-Google-Smtp-Source: AK7set/MQ8Tk7hqjQ76aZeeGqsk+sTc8Mc/SmS8lSnOfUFBQu8eBQvHT1fukv8FMeLV3uk7gnj05AQ==
X-Received: by 2002:ac8:7c48:0:b0:3b8:36f8:830e with SMTP id o8-20020ac87c48000000b003b836f8830emr348153qtv.6.1679594029798;
        Thu, 23 Mar 2023 10:53:49 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v10-20020ac873ca000000b003e29583cf22sm6779882qtp.91.2023.03.23.10.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 10:53:49 -0700 (PDT)
Message-ID: <5463b973-7395-8150-f1f7-fe26c3d86443@redhat.com>
Date:   Thu, 23 Mar 2023 13:53:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 2/4] exports: Add an xprtsec= export option
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
 <167932293857.3437.10836642078898996996.stgit@manet.1015granger.net>
 <b1da1fdbb190f50409f9fcd18b466defdfc04353.camel@kernel.org>
 <07F10068-A3E6-4C45-BB1E-F67FF4378155@oracle.com>
 <01df993e636b200dbd7636946761208bb183d5c7.camel@kernel.org>
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <01df993e636b200dbd7636946761208bb183d5c7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Sorry for the delayed response....

On 3/21/23 2:58 PM, Jeff Layton wrote:
> On Tue, 2023-03-21 at 18:08 +0000, Chuck Lever III wrote:
>>
>>> On Mar 21, 2023, at 7:55 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>
>>> On Mon, 2023-03-20 at 10:35 -0400, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> The overall goal is to enable administrators to require the use of
>>>> transport layer security when clients access particular exports.
>>>>
>>>> This patch adds support to exportfs to parse and display a new
>>>> xprtsec= export option. The setting is not yet passed to the kernel.
>>>>
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>> support/include/nfs/export.h |    6 +++
>>>> support/include/nfslib.h     |   14 +++++++
>>>> support/nfs/exports.c        |   85 ++++++++++++++++++++++++++++++++++++++++++
>>>> utils/exportfs/exportfs.c    |    1
>>>> 4 files changed, 106 insertions(+)
>>>>
>>>> diff --git a/support/include/nfs/export.h b/support/include/nfs/export.h
>>>> index 0eca828ee3ad..b29c6fa4f554 100644
>>>> --- a/support/include/nfs/export.h
>>>> +++ b/support/include/nfs/export.h
>>>> @@ -40,4 +40,10 @@
>>>> #define NFSEXP_OLD_SECINFO_FLAGS (NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
>>>> 					| NFSEXP_ALLSQUASH)
>>>>
>>>> +enum {
>>>> +	NFSEXP_XPRTSEC_NONE = 1,
>>>> +	NFSEXP_XPRTSEC_TLS = 2,
>>>> +	NFSEXP_XPRTSEC_MTLS = 3,
>>>> +};
>>>> +
>>>
>>> Can we put these into a uapi header somewhere and then just have
>>> nfs-utils use those if they're defined?
>>
>> I moved these to include/uapi/linux/nfsd/export.h in the
>> kernel patches, and adjust the nfs-utils patches to use the
>> same numeric values in exportfs as the kernel.
>>
>> But it's not clear how a uAPI header would become visible
>> during, say, an RPM build of nfs-utils. Does anyone know
>> how that works? The kernel docs I've read suggest uAPI is
>> for user space tools that actually live in the kernel source
>> tree.
>>
> 
> Unfortunately, you need to build on a box that has kernel headers from
> an updated kernel.
I would not like to add this dependency to nfs-utils or sub-packages.

> 
> The usual way to deal with this is to have a copy in the userland
> sources but only define them if one of the relevant constants isn't
> already defined.
> 
> So you'll probably want to keep something like this in the userland
> tree:
> 
> #ifndef NFSEXP_XPRTSEC_NONE
> # define NFSEXP_XPRTSEC_NONE 1
> # define NFSEXP_XPRTSEC_TLS  2
> # define NFSEXP_XPRTSEC_MTLS 3
> #endif
> 
> There may be some way to do that and keep it as an enum too. I'm not
> sure.
Is there a reason these could not be in export.h?

steved.

> 
>> I think the cases where only user space or only the kernel
>> support xprtsec should work OK: the kernel has a default
>> transport layer security policy of "all ok" and old kernels
>> ignore export options from user space they don't recognize.
>>
> 
> Great!
> 
>>>> #endif /* _NSF_EXPORT_H */
>>>> diff --git a/support/include/nfslib.h b/support/include/nfslib.h
>>>> index 6faba71bf0cd..9a188fb84790 100644
>>>> --- a/support/include/nfslib.h
>>>> +++ b/support/include/nfslib.h
>>>> @@ -62,6 +62,18 @@ struct sec_entry {
>>>> 	int flags;
>>>> };
>>>>
>>>> +#define XPRTSECMODE_COUNT 4
>>>> +
>>>> +struct xprtsec_info {
>>>> +	const char		*name;
>>>> +	int			number;
>>>> +};
>>>> +
>>>> +struct xprtsec_entry {
>>>> +	const struct xprtsec_info *info;
>>>> +	int			flags;
>>>> +};
>>>> +
>>>> /*
>>>>   * Data related to a single exports entry as returned by getexportent.
>>>>   * FIXME: export options should probably be parsed at a later time to
>>>> @@ -83,6 +95,7 @@ struct exportent {
>>>> 	char *          e_fslocdata;
>>>> 	char *		e_uuid;
>>>> 	struct sec_entry e_secinfo[SECFLAVOR_COUNT+1];
>>>> +	struct xprtsec_entry e_xprtsec[XPRTSECMODE_COUNT + 1];
>>>> 	unsigned int	e_ttl;
>>>> 	char *		e_realpath;
>>>> };
>>>> @@ -99,6 +112,7 @@ struct rmtabent {
>>>> void			setexportent(char *fname, char *type);
>>>> struct exportent *	getexportent(int,int);
>>>> void 			secinfo_show(FILE *fp, struct exportent *ep);
>>>> +void			xprtsecinfo_show(FILE *fp, struct exportent *ep);
>>>> void			putexportent(struct exportent *xep);
>>>> void			endexportent(void);
>>>> struct exportent *	mkexportent(char *hname, char *path, char *opts);
>>>> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
>>>> index 7f12383981c3..da8ace3a65fd 100644
>>>> --- a/support/nfs/exports.c
>>>> +++ b/support/nfs/exports.c
>>>> @@ -99,6 +99,7 @@ static void init_exportent (struct exportent *ee, int fromkernel)
>>>> 	ee->e_fslocmethod = FSLOC_NONE;
>>>> 	ee->e_fslocdata = NULL;
>>>> 	ee->e_secinfo[0].flav = NULL;
>>>> +	ee->e_xprtsec[0].info = NULL;
>>>> 	ee->e_nsquids = 0;
>>>> 	ee->e_nsqgids = 0;
>>>> 	ee->e_uuid = NULL;
>>>> @@ -248,6 +249,17 @@ void secinfo_show(FILE *fp, struct exportent *ep)
>>>> 	}
>>>> }
>>>>
>>>> +void xprtsecinfo_show(FILE *fp, struct exportent *ep)
>>>> +{
>>>> +	struct xprtsec_entry *p1, *p2;
>>>> +
>>>> +	for (p1 = ep->e_xprtsec; p1->info; p1 = p2) {
>>>> +		fprintf(fp, ",xprtsec=%s", p1->info->name);
>>>> +		for (p2 = p1 + 1; p2->info && (p1->flags == p2->flags); p2++)
>>>> +			fprintf(fp, ":%s", p2->info->name);
>>>> +	}
>>>> +}
>>>> +
>>>> static void
>>>> fprintpath(FILE *fp, const char *path)
>>>> {
>>>> @@ -344,6 +356,7 @@ putexportent(struct exportent *ep)
>>>> 	}
>>>> 	fprintf(fp, "anonuid=%d,anongid=%d", ep->e_anonuid, ep->e_anongid);
>>>> 	secinfo_show(fp, ep);
>>>> +	xprtsecinfo_show(fp, ep);
>>>> 	fprintf(fp, ")\n");
>>>> }
>>>>
>>>> @@ -482,6 +495,75 @@ static unsigned int parse_flavors(char *str, struct exportent *ep)
>>>> 	return out;
>>>> }
>>>>
>>>> +static const struct xprtsec_info xprtsec_name2info[] = {
>>>> +	{ "none",	NFSEXP_XPRTSEC_NONE },
>>>> +	{ "tls",	NFSEXP_XPRTSEC_TLS },
>>>> +	{ "mtls",	NFSEXP_XPRTSEC_MTLS },
>>>> +	{ NULL,		0 }
>>>> +};
>>>> +
>>>> +static const struct xprtsec_info *find_xprtsec_info(const char *name)
>>>> +{
>>>> +	const struct xprtsec_info *info;
>>>> +
>>>> +	for (info = xprtsec_name2info; info->name; info++)
>>>> +		if (strcmp(info->name, name) == 0)
>>>> +			return info;
>>>> +	return NULL;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Append the given xprtsec mode to the exportent's e_xprtsec array,
>>>> + * or do nothing if it's already there. Returns the index of flavor in
>>>> + * the resulting array in any case.
>>>> + */
>>>> +static int xprtsec_addmode(const struct xprtsec_info *info, struct exportent *ep)
>>>> +{
>>>> +	struct xprtsec_entry *p;
>>>> +
>>>> +	for (p = ep->e_xprtsec; p->info; p++)
>>>> +		if (p->info == info || p->info->number == info->number)
>>>> +			return p - ep->e_xprtsec;
>>>> +
>>>> +	if (p - ep->e_xprtsec >= XPRTSECMODE_COUNT) {
>>>> +		xlog(L_ERROR, "more than %d xprtsec modes on an export\n",
>>>> +			XPRTSECMODE_COUNT);
>>>> +		return -1;
>>>> +	}
>>>> +	p->info = info;
>>>> +	p->flags = ep->e_flags;
>>>> +	(p + 1)->info = NULL;
>>>> +	return p - ep->e_xprtsec;
>>>> +}
>>>> +
>>>> +/*
>>>> + * @str is a colon seperated list of transport layer security modes.
>>>> + * Their order is recorded in @ep, and a bitmap corresponding to the
>>>> + * list is returned.
>>>> + *
>>>> + * A zero return indicates an error.
>>>> + */
>>>> +static unsigned int parse_xprtsec(char *str, struct exportent *ep)
>>>> +{
>>>> +	unsigned int out = 0;
>>>> +	char *name;
>>>> +
>>>> +	while ((name = strsep(&str, ":"))) {
>>>> +		const struct xprtsec_info *info = find_xprtsec_info(name);
>>>> +		int bit;
>>>> +
>>>> +		if (!info) {
>>>> +			xlog(L_ERROR, "unknown xprtsec mode %s\n", name);
>>>> +			return 0;
>>>> +		}
>>>> +		bit = xprtsec_addmode(info, ep);
>>>> +		if (bit < 0)
>>>> +			return 0;
>>>> +		out |= 1 << bit;
>>>> +	}
>>>> +	return out;
>>>> +}
>>>> +
>>>> /* Sets the bits in @mask for the appropriate security flavor flags. */
>>>> static void setflags(int mask, unsigned int active, struct exportent *ep)
>>>> {
>>>> @@ -687,6 +769,9 @@ bad_option:
>>>> 			active = parse_flavors(opt+4, ep);
>>>> 			if (!active)
>>>> 				goto bad_option;
>>>> +		} else if (strncmp(opt, "xprtsec=", 8) == 0) {
>>>> +			if (!parse_xprtsec(opt + 8, ep))
>>>> +				goto bad_option;
>>>> 		} else {
>>>> 			xlog(L_ERROR, "%s:%d: unknown keyword \"%s\"\n",
>>>> 					flname, flline, opt);
>>>> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
>>>> index 6d79a5b3480d..37b9e4b3612d 100644
>>>> --- a/utils/exportfs/exportfs.c
>>>> +++ b/utils/exportfs/exportfs.c
>>>> @@ -743,6 +743,7 @@ dump(int verbose, int export_format)
>>>> #endif
>>>> 			}
>>>> 			secinfo_show(stdout, ep);
>>>> +			xprtsecinfo_show(stdout, ep);
>>>> 			printf("%c\n", (c != '(')? ')' : ' ');
>>>> 		}
>>>> 	}
>>>>
>>>>
>>>
>>> -- 
>>> Jeff Layton <jlayton@kernel.org>
>>
>> --
>> Chuck Lever
>>
>>
> 

