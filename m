Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB772521C9D
	for <lists+linux-nfs@lfdr.de>; Tue, 10 May 2022 16:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244266AbiEJOo7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 May 2022 10:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244193AbiEJOom (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 May 2022 10:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF2D820F9F7
        for <linux-nfs@vger.kernel.org>; Tue, 10 May 2022 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652191446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1GhjJYQzsqZPFO4zMqIBa9KA72EcYG9lSRetkCoveM=;
        b=Dkp0CaqYekemxm1yCY3hrB8kEPfU/33XM1aM2DSkzjej0HnHrbZkeAuKjfE5gTUFZCNLkc
        Iz9+Kn/UEDMaRcq1VRtbJQzBT9TkLfbHF1LaNcXYlhYjnijab71Xt/jYreAKAgDZ/A312t
        OhFQjd54QMOXUcyBJNpGSgSPXg7B8tU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-V8sn1UqEOjiHHc-14FdyNg-1; Tue, 10 May 2022 10:04:05 -0400
X-MC-Unique: V8sn1UqEOjiHHc-14FdyNg-1
Received: by mail-qt1-f200.google.com with SMTP id f12-20020a05622a1a0c00b002f3b5acc2e7so14598881qtb.1
        for <linux-nfs@vger.kernel.org>; Tue, 10 May 2022 07:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r1GhjJYQzsqZPFO4zMqIBa9KA72EcYG9lSRetkCoveM=;
        b=2OLVabfxtK26RgPOotU+yG96U8hfCaO2uBstfiQEdRWwYrRvY3XJGYwn7G0EUc7PzQ
         9kaDRv2IS1F1tUu+LZL5Nsg/ZZY2H79xfDsJNbU/EeTyF0sL1GBSuDSNSwoLVd73bs2W
         fnevpF0Itbd3p0SmlWhsyeZBaaFTzIomR5V0Kj9yWFSX0sB7W/Dp/E6A6UJM1tHhEUSR
         JPcpFGoQb1zHxgsVRHP55FQ9F8t7dzDu4cmcXRYtbB41iOQ5UFL718n5hf4GUW+wI9tA
         CyvbQwE78PNctjIEkYNbTo3EtxzTEghGLzPiczD7AjTjVMwBJ6VjHUu8StSI/83GMUXm
         bZzA==
X-Gm-Message-State: AOAM531udYfWa4Zfz99Q6N8HmgN5W0DyF5JqH1Mx98/iXa1NDsNzAhZ5
        2qR3U4cAd7WAH7hSqnIUIR/gq9cRsU1zHP45FCtc2+hlRnX3Q2KWu1ehMq3dRsxn64Co1RYLdif
        HFmiYs8XmiI1JtWdsx3IO
X-Received: by 2002:a05:622a:1a26:b0:2f3:b9d5:779b with SMTP id f38-20020a05622a1a2600b002f3b9d5779bmr19354935qtb.641.1652191444881;
        Tue, 10 May 2022 07:04:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm3rtMNwpFkLxZWXf5OJf270Zm0xtHnTN8VogbL0y/FqOuK9TkXfGMTMb+R3LWW1MiQLuEjQ==
X-Received: by 2002:a05:622a:1a26:b0:2f3:b9d5:779b with SMTP id f38-20020a05622a1a2600b002f3b9d5779bmr19354872qtb.641.1652191444346;
        Tue, 10 May 2022 07:04:04 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b14-20020a05620a0cce00b0069fd2a10ef7sm8390544qkj.100.2022.05.10.07.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 07:04:03 -0700 (PDT)
Message-ID: <fe2ecc50-4036-2922-28d6-e2f139408961@redhat.com>
Date:   Tue, 10 May 2022 10:04:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/5] Implement reexport helper library
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        david <david@sigma-star.at>, Bruce Fields <bfields@fieldses.org>,
        "luis.turcitu@appsbroker.com" <luis.turcitu@appsbroker.com>,
        "david.young@appsbroker.com" <david.young@appsbroker.com>,
        "david.oberhollenzer@sigma-star.at" 
        <david.oberhollenzer@sigma-star.at>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "chris.chilvers@appsbroker.com" <chris.chilvers@appsbroker.com>
References: <20220502085045.13038-1-richard@nod.at>
 <20220502085045.13038-2-richard@nod.at>
 <f4ae288c-b7f3-25fe-ef08-7b37256771bb@redhat.com>
 <1A6F1763-C95B-4678-B622-6D3300AF087E@oracle.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <1A6F1763-C95B-4678-B622-6D3300AF087E@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

On 5/10/22 9:48 AM, Chuck Lever III wrote:
> 
> 
>> On May 10, 2022, at 9:32 AM, Steve Dickson <steved@redhat.com> wrote:
>>
>> Hello,
>>
>> On 5/2/22 4:50 AM, Richard Weinberger wrote:
>>> This internal library contains code that will be used by various
>>> tools within the nfs-utils package to deal better with NFS re-export,
>>> especially cross mounts.
>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>> ---
>>>   configure.ac                 |  12 ++
>>>   support/Makefile.am          |   4 +
>>>   support/reexport/Makefile.am |   6 +
>>>   support/reexport/reexport.c  | 285 +++++++++++++++++++++++++++++++++++
>>>   support/reexport/reexport.h  |  39 +++++
>>>   5 files changed, 346 insertions(+)
>>>   create mode 100644 support/reexport/Makefile.am
>>>   create mode 100644 support/reexport/reexport.c
>>>   create mode 100644 support/reexport/reexport.h
>>> diff --git a/configure.ac b/configure.ac
>>> index 93626d62..86bf8ba9 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -274,6 +274,17 @@ AC_ARG_ENABLE(nfsv4server,
>>>   	fi
>>>   	AM_CONDITIONAL(CONFIG_NFSV4SERVER, [test "$enable_nfsv4server" = "yes" ])
>>>   +AC_ARG_ENABLE(reexport,
>>> +	[AC_HELP_STRING([--enable-reexport],
>>> +			[enable support for re-exporting NFS mounts  @<:@default=no@:>@])],
>>> +	enable_reexport=$enableval,
>>> +	enable_reexport="no")
>>> +	if test "$enable_reexport" = yes; then
>>> +		AC_DEFINE(HAVE_REEXPORT_SUPPORT, 1,
>>> +                          [Define this if you want NFS re-export support compiled in])
>>> +	fi
>>> +	AM_CONDITIONAL(CONFIG_REEXPORT, [test "$enable_reexport" = "yes" ])
>>> +
>> To get this moving I'm going to add a --disable-reexport flag
> 
> Hi Steve, no-one has given a reason why disabling support
> for re-exports would be necessary. Therefore, can't this
> switch just be removed?The precedence has been that we used --disable-XXX flag
a lot in configure.ac... -nfsv4, -nfsv41, etc...
I'm just following along with that.

Yes, at this point, nobody is asking to turn it off but
in future somebody may want to... due some security hole
or just make the footprint of the package smaller.

I've always though it was a good idea to be able
to turn things off.. esp if the feature will
not be used.

steved.

> 
> 
>> +AC_ARG_ENABLE(reexport,
>> +       [AC_HELP_STRING([--disable-reexport],
>> +                       [disable support for re-exporting NFS mounts @<:@default=no@:>@])],
>> +       enable_reexport=$enableval,
>> +       enable_reexport="yes")
>> +       if test "$enable_reexport" = yes; then
>> +               AC_DEFINE(HAVE_REEXPORT_SUPPORT, 1,
>> +                          [Define this if you want NFS re-export support compiled in])
>> +       fi
>> +       AM_CONDITIONAL(CONFIG_REEXPORT, [test "$enable_reexport" = "yes" ])
>> +
>>
>> steved.
>>
>>>   dnl Check for TI-RPC library and headers
>>>   AC_LIBTIRPC
>>>   @@ -730,6 +741,7 @@ AC_CONFIG_FILES([
>>>   	support/nsm/Makefile
>>>   	support/nfsidmap/Makefile
>>>   	support/nfsidmap/libnfsidmap.pc
>>> +	support/reexport/Makefile
>>>   	tools/Makefile
>>>   	tools/locktest/Makefile
>>>   	tools/nlmtest/Makefile
>>> diff --git a/support/Makefile.am b/support/Makefile.am
>>> index c962d4d4..986e9b5f 100644
>>> --- a/support/Makefile.am
>>> +++ b/support/Makefile.am
>>> @@ -10,6 +10,10 @@ if CONFIG_JUNCTION
>>>   OPTDIRS += junction
>>>   endif
>>>   +if CONFIG_REEXPORT
>>> +OPTDIRS += reexport
>>> +endif
>>> +
>>>   SUBDIRS = export include misc nfs nsm $(OPTDIRS)
>>>     MAINTAINERCLEANFILES = Makefile.in
>>> diff --git a/support/reexport/Makefile.am b/support/reexport/Makefile.am
>>> new file mode 100644
>>> index 00000000..9d544a8f
>>> --- /dev/null
>>> +++ b/support/reexport/Makefile.am
>>> @@ -0,0 +1,6 @@
>>> +## Process this file with automake to produce Makefile.in
>>> +
>>> +noinst_LIBRARIES = libreexport.a
>>> +libreexport_a_SOURCES = reexport.c
>>> +
>>> +MAINTAINERCLEANFILES = Makefile.in
>>> diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
>>> new file mode 100644
>>> index 00000000..5474a21f
>>> --- /dev/null
>>> +++ b/support/reexport/reexport.c
>>> @@ -0,0 +1,285 @@
>>> +#ifdef HAVE_CONFIG_H
>>> +#include <config.h>
>>> +#endif
>>> +
>>> +#include <sqlite3.h>
>>> +#include <stdint.h>
>>> +#include <stdio.h>
>>> +#include <sys/random.h>
>>> +#include <sys/stat.h>
>>> +#include <sys/types.h>
>>> +#include <sys/vfs.h>
>>> +#include <unistd.h>
>>> +
>>> +#include "nfsd_path.h"
>>> +#include "nfslib.h"
>>> +#include "reexport.h"
>>> +#include "xcommon.h"
>>> +#include "xlog.h"
>>> +
>>> +#define REEXPDB_DBFILE NFS_STATEDIR "/reexpdb.sqlite3"
>>> +#define REEXPDB_DBFILE_WAIT_USEC (5000)
>>> +
>>> +static sqlite3 *db;
>>> +static int init_done;
>>> +
>>> +static int prng_init(void)
>>> +{
>>> +	int seed;
>>> +
>>> +	if (getrandom(&seed, sizeof(seed), 0) != sizeof(seed)) {
>>> +		xlog(L_ERROR, "Unable to obtain seed for PRNG via getrandom()");
>>> +		return -1;
>>> +	}
>>> +
>>> +	srand(seed);
>>> +	return 0;
>>> +}
>>> +
>>> +static void wait_for_dbaccess(void)
>>> +{
>>> +	usleep(REEXPDB_DBFILE_WAIT_USEC + (rand() % REEXPDB_DBFILE_WAIT_USEC));
>>> +}
>>> +
>>> +/*
>>> + * reexpdb_init - Initialize reexport database
>>> + */
>>> +int reexpdb_init(void)
>>> +{
>>> +	char *sqlerr;
>>> +	int ret;
>>> +
>>> +	if (init_done)
>>> +		return 0;
>>> +
>>> +	if (prng_init() != 0)
>>> +		return -1;
>>> +
>>> +	ret = sqlite3_open_v2(REEXPDB_DBFILE, &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE | SQLITE_OPEN_FULLMUTEX, NULL);
>>> +	if (ret != SQLITE_OK) {
>>> +		xlog(L_ERROR, "Unable to open reexport database: %s", sqlite3_errstr(ret));
>>> +		return -1;
>>> +	}
>>> +
>>> +again:
>>> +	ret = sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS fsidnums (num INTEGER PRIMARY KEY CHECK (num > 0 AND num < 4294967296), path TEXT UNIQUE); CREATE INDEX IF NOT EXISTS idx_ids_path ON fsidnums (path);", NULL, NULL, &sqlerr);
>>> +	switch (ret) {
>>> +	case SQLITE_OK:
>>> +		init_done = 1;
>>> +		ret = 0;
>>> +		break;
>>> +	case SQLITE_BUSY:
>>> +	case SQLITE_LOCKED:
>>> +		wait_for_dbaccess();
>>> +		goto again;
>>> +	default:
>>> +		xlog(L_ERROR, "Unable to init reexport database: %s", sqlite3_errstr(ret));
>>> +		sqlite3_free(sqlerr);
>>> +		sqlite3_close_v2(db);
>>> +		ret = -1;
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +/*
>>> + * reexpdb_destroy - Undo reexpdb_init().
>>> + */
>>> +void reexpdb_destroy(void)
>>> +{
>>> +	if (!init_done)
>>> +		return;
>>> +
>>> +	sqlite3_close_v2(db);
>>> +}
>>> +
>>> +static int get_fsidnum_by_path(char *path, uint32_t *fsidnum)
>>> +{
>>> +	static const char fsidnum_by_path_sql[] = "SELECT num FROM fsidnums WHERE path = ?1;";
>>> +	sqlite3_stmt *stmt = NULL;
>>> +	int found = 0;
>>> +	int ret;
>>> +
>>> +	ret = sqlite3_prepare_v2(db, fsidnum_by_path_sql, sizeof(fsidnum_by_path_sql), &stmt, NULL);
>>> +	if (ret != SQLITE_OK) {
>>> +		xlog(L_WARNING, "Unable to prepare SQL query '%s': %s", fsidnum_by_path_sql, sqlite3_errstr(ret));
>>> +		goto out;
>>> +	}
>>> +
>>> +	ret = sqlite3_bind_text(stmt, 1, path, -1, NULL);
>>> +	if (ret != SQLITE_OK) {
>>> +		xlog(L_WARNING, "Unable to bind SQL query '%s': %s", fsidnum_by_path_sql, sqlite3_errstr(ret));
>>> +		goto out;
>>> +	}
>>> +
>>> +again:
>>> +	ret = sqlite3_step(stmt);
>>> +	switch (ret) {
>>> +	case SQLITE_ROW:
>>> +		*fsidnum = sqlite3_column_int(stmt, 0);
>>> +		found = 1;
>>> +		break;
>>> +	case SQLITE_DONE:
>>> +		/* No hit */
>>> +		found = 0;
>>> +		break;
>>> +	case SQLITE_BUSY:
>>> +	case SQLITE_LOCKED:
>>> +		wait_for_dbaccess();
>>> +		goto again;
>>> +	default:
>>> +		xlog(L_WARNING, "Error while looking up '%s' in database: %s", path, sqlite3_errstr(ret));
>>> +	}
>>> +
>>> +out:
>>> +	sqlite3_finalize(stmt);
>>> +	return found;
>>> +}
>>> +
>>> +static int get_path_by_fsidnum(uint32_t fsidnum, char **path)
>>> +{
>>> +	static const char path_by_fsidnum_sql[] = "SELECT path FROM fsidnums WHERE num = ?1;";
>>> +	sqlite3_stmt *stmt = NULL;
>>> +	int found = 0;
>>> +	int ret;
>>> +
>>> +	ret = sqlite3_prepare_v2(db, path_by_fsidnum_sql, sizeof(path_by_fsidnum_sql), &stmt, NULL);
>>> +	if (ret != SQLITE_OK) {
>>> +		xlog(L_WARNING, "Unable to prepare SQL query '%s': %s", path_by_fsidnum_sql, sqlite3_errstr(ret));
>>> +		goto out;
>>> +	}
>>> +
>>> +	ret = sqlite3_bind_int(stmt, 1, fsidnum);
>>> +	if (ret != SQLITE_OK) {
>>> +		xlog(L_WARNING, "Unable to bind SQL query '%s': %s", path_by_fsidnum_sql, sqlite3_errstr(ret));
>>> +		goto out;
>>> +	}
>>> +
>>> +again:
>>> +	ret = sqlite3_step(stmt);
>>> +	switch (ret) {
>>> +	case SQLITE_ROW:
>>> +		*path = xstrdup((char *)sqlite3_column_text(stmt, 0));
>>> +		found = 1;
>>> +		break;
>>> +	case SQLITE_DONE:
>>> +		/* No hit */
>>> +		found = 0;
>>> +		break;
>>> +	case SQLITE_BUSY:
>>> +	case SQLITE_LOCKED:
>>> +		wait_for_dbaccess();
>>> +		goto again;
>>> +	default:
>>> +		xlog(L_WARNING, "Error while looking up '%i' in database: %s", fsidnum, sqlite3_errstr(ret));
>>> +	}
>>> +
>>> +out:
>>> +	sqlite3_finalize(stmt);
>>> +	return found;
>>> +}
>>> +
>>> +static int new_fsidnum_by_path(char *path, uint32_t *fsidnum)
>>> +{
>>> +	/*
>>> +	 * This query is a little tricky. We use SQL to find and claim the smallest free fsid number.
>>> +	 * To find a free fsid the fsidnums is left joined to itself but with an offset of 1.
>>> +	 * Everything after the UNION statement is to handle the corner case where fsidnums
>>> +	 * is empty. In this case we want 1 as first fsid number.
>>> +	 */
>>> +	static const char new_fsidnum_by_path_sql[] = "INSERT INTO fsidnums VALUES ((SELECT ids1.num + 1 FROM fsidnums AS ids1 LEFT JOIN fsidnums AS ids2 ON ids2.num = ids1.num + 1 WHERE ids2.num IS NULL UNION SELECT 1 WHERE NOT EXISTS (SELECT NULL FROM fsidnums WHERE num = 1) LIMIT 1), ?1) RETURNING num;";
>>> +
>>> +	sqlite3_stmt *stmt = NULL;
>>> +	int found = 0, check = 0;
>>> +	int ret;
>>> +
>>> +	ret = sqlite3_prepare_v2(db, new_fsidnum_by_path_sql, sizeof(new_fsidnum_by_path_sql), &stmt, NULL);
>>> +	if (ret != SQLITE_OK) {
>>> +		xlog(L_WARNING, "Unable to prepare SQL query '%s': %s", new_fsidnum_by_path_sql, sqlite3_errstr(ret));
>>> +		goto out;
>>> +	}
>>> +
>>> +	ret = sqlite3_bind_text(stmt, 1, path, -1, NULL);
>>> +	if (ret != SQLITE_OK) {
>>> +		xlog(L_WARNING, "Unable to bind SQL query '%s': %s", new_fsidnum_by_path_sql, sqlite3_errstr(ret));
>>> +		goto out;
>>> +	}
>>> +
>>> +again:
>>> +	ret = sqlite3_step(stmt);
>>> +	switch (ret) {
>>> +	case SQLITE_ROW:
>>> +		*fsidnum = sqlite3_column_int(stmt, 0);
>>> +		found = 1;
>>> +		break;
>>> +	case SQLITE_CONSTRAINT:
>>> +		/* Maybe we lost the race against another writer and the path is now present. */
>>> +		check = 1;
>>> +		break;
>>> +	case SQLITE_BUSY:
>>> +	case SQLITE_LOCKED:
>>> +		wait_for_dbaccess();
>>> +		goto again;
>>> +	default:
>>> +		xlog(L_WARNING, "Error while looking up '%s' in database: %s", path, sqlite3_errstr(ret));
>>> +	}
>>> +
>>> +out:
>>> +	sqlite3_finalize(stmt);
>>> +
>>> +	if (check) {
>>> +		found = get_fsidnum_by_path(path, fsidnum);
>>> +		if (!found)
>>> +			xlog(L_WARNING, "SQLITE_CONSTRAINT error while inserting '%s' in database", path);
>>> +	}
>>> +
>>> +	return found;
>>> +}
>>> +
>>> +/*
>>> + * reexpdb_fsidnum_by_path - Lookup a fsid by path.
>>> + *
>>> + * @path: File system path used as lookup key
>>> + * @fsidnum: Pointer where found fsid is written to
>>> + * @may_create: If non-zero, allocate new fsid if lookup failed
>>> + *
>>> + */
>>> +int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidnum, int may_create)
>>> +{
>>> +	int found;
>>> +
>>> +	found = get_fsidnum_by_path(path, fsidnum);
>>> +
>>> +	if (!found && may_create)
>>> +		found = new_fsidnum_by_path(path, fsidnum);
>>> +
>>> +	return found;
>>> +}
>>> +
>>> +/*
>>> + * reexpdb_uncover_subvolume - Make sure a subvolume is present.
>>> + *
>>> + * @fsidnum: Numerical fsid number to look for
>>> + *
>>> + * Subvolumes (NFS cross mounts) get automatically mounted upon first
>>> + * access and can vanish after fs.nfs.nfs_mountpoint_timeout seconds.
>>> + * Also if the NFS server reboots, clients can still have valid file
>>> + * handles for such a subvolume.
>>> + *
>>> + * If kNFSd asks mountd for the path of a given fsidnum it can
>>> + * trigger an automount by calling statfs() on the given path.
>>> + */
>>> +void reexpdb_uncover_subvolume(uint32_t fsidnum)
>>> +{
>>> +	struct statfs64 st;
>>> +	char *path = NULL;
>>> +	int ret;
>>> +
>>> +	if (get_path_by_fsidnum(fsidnum, &path)) {
>>> +		ret = nfsd_path_statfs64(path, &st);
>>> +		if (ret == -1)
>>> +			xlog(L_WARNING, "statfs() failed");
>>> +	}
>>> +
>>> +	free(path);
>>> +}
>>> diff --git a/support/reexport/reexport.h b/support/reexport/reexport.h
>>> new file mode 100644
>>> index 00000000..bb6d2a1b
>>> --- /dev/null
>>> +++ b/support/reexport/reexport.h
>>> @@ -0,0 +1,39 @@
>>> +#ifndef REEXPORT_H
>>> +#define REEXPORT_H
>>> +
>>> +enum {
>>> +	REEXP_NONE = 0,
>>> +	REEXP_AUTO_FSIDNUM,
>>> +	REEXP_PREDEFINED_FSIDNUM,
>>> +};
>>> +
>>> +#ifdef HAVE_REEXPORT_SUPPORT
>>> +int reexpdb_init(void);
>>> +void reexpdb_destroy(void);
>>> +int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidnum, int may_create);
>>> +int reexpdb_apply_reexport_settings(struct exportent *ep, char *flname, int flline);
>>> +void reexpdb_uncover_subvolume(uint32_t fsidnum);
>>> +#else
>>> +static inline int reexpdb_init(void) { return 0; }
>>> +static inline void reexpdb_destroy(void) {}
>>> +static inline int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidnum, int may_create)
>>> +{
>>> +	(void)path;
>>> +	(void)may_create;
>>> +	*fsidnum = 0;
>>> +	return 0;
>>> +}
>>> +static inline int reexpdb_apply_reexport_settings(struct exportent *ep, char *flname, int flline)
>>> +{
>>> +	(void)ep;
>>> +	(void)flname;
>>> +	(void)flline;
>>> +	return 0;
>>> +}
>>> +static inline void reexpdb_uncover_subvolume(uint32_t fsidnum)
>>> +{
>>> +	(void)fsidnum;
>>> +}
>>> +#endif /* HAVE_REEXPORT_SUPPORT */
>>> +
>>> +#endif /* REEXPORT_H */
>>
> 
> --
> Chuck Lever
> 
> 
> 

