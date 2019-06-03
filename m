Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5F29331E9
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2019 16:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfFCOTB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jun 2019 10:19:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbfFCOTB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Jun 2019 10:19:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 397FA3DDBE;
        Mon,  3 Jun 2019 14:18:56 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-46.phx2.redhat.com [10.3.116.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8276E605CA;
        Mon,  3 Jun 2019 14:18:54 +0000 (UTC)
Subject: Re: [PATCH v3 08/11] Add support for the "[exports] rootdir" nfs.conf
 option to rpc.mountd
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trondmy@gmail.com>
Cc:     linux-nfs@vger.kernel.org
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
 <20190528203122.11401-2-trond.myklebust@hammerspace.com>
 <20190528203122.11401-3-trond.myklebust@hammerspace.com>
 <20190528203122.11401-4-trond.myklebust@hammerspace.com>
 <20190528203122.11401-5-trond.myklebust@hammerspace.com>
 <20190528203122.11401-6-trond.myklebust@hammerspace.com>
 <20190528203122.11401-7-trond.myklebust@hammerspace.com>
 <20190528203122.11401-8-trond.myklebust@hammerspace.com>
 <20190528203122.11401-9-trond.myklebust@hammerspace.com>
 <20190531160224.GD1251@fieldses.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <3b9913c5-6ec7-aea8-fa03-bcabdac2f59c@RedHat.com>
Date:   Mon, 3 Jun 2019 10:18:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531160224.GD1251@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 03 Jun 2019 14:19:01 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/31/19 12:02 PM, J. Bruce Fields wrote:
> On Tue, May 28, 2019 at 04:31:19PM -0400, Trond Myklebust wrote:
>> @@ -373,21 +390,22 @@ static char *next_mnt(void **v, char *p)
>>  	FILE *f;
>>  	struct mntent *me;
>>  	size_t l = strlen(p);
>> +	char *mnt_dir = NULL;
>> +
>>  	if (*v == NULL) {
>>  		f = setmntent("/etc/mtab", "r");
>>  		*v = f;
>>  	} else
>>  		f = *v;
>> -	while ((me = getmntent(f)) != NULL && l > 1 &&
>> -	       (strncmp(me->mnt_dir, p, l) != 0 ||
>> -		me->mnt_dir[l] != '/'))
>> -		;
>> -	if (me == NULL) {
>> -		endmntent(f);
>> -		*v = NULL;
>> -		return NULL;
>> +	while ((me = getmntent(f)) != NULL && l > 1) {
>> +		mnt_dir = nfsd_path_strip_root(me->mnt_dir);
>> +
>> +		if (strncmp(mnt_dir, p, l) == 0 && mnt_dir[l] != '/')
>> +			return mnt_dir;
> 
> That should be "mnt_dir[l] == '/'", right?
Comment says
/* Iterate through /etc/mtab, finding mountpoints
 * at or below a given path
 */

So I don't think the actual '/' should returned, Trond?

steved.
> 
> --b.
> 
>>  	}
>> -	return me->mnt_dir;
>> +	endmntent(f);
>> +	*v = NULL;
>> +	return NULL;
>>  }
>>  
>>  /* same_path() check is two paths refer to the same directory.
