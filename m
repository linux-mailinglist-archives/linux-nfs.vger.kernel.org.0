Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B532A2DEB
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 16:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgKBPRA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 10:17:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51682 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgKBPRA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 10:17:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A2FFcuI155929;
        Mon, 2 Nov 2020 15:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Ya0sngalmRLYnzxqmY+s7IDZ/Kr+fNnu4UD2WjsSnIQ=;
 b=aHOtnsS7PR6lubSMfluzaw4tVya3gvKRYCLIhW3DbwLnzXPodwlQmhCTuLmxJeKrOnXt
 Dc6HD7vl1VdtFFV6WPiEhxleN2Plh+G551PYqD5XjbPou2yUH/V39qqCgJXwmkpZkCio
 4wlu8cCDMiad3oH8eplbYm+JOCyrsNHvE2l5eeUt34/tA6wGuCA1EgMW+ToGoVXpP6i4
 h24Pbqubpb57n7C5FFwVT4yJHe+HVGegYJgtYo5L9+JFla6G60rqgqW+iXTE81o9f3Ok
 rBvKo4wQrlw6AtFytOlWTiJL1j6BxSgqfDTWdCvktuwOr08DJ1jT4HuVdY5LEFBzBmeT HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34hhvc4cy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 02 Nov 2020 15:16:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A2FFeiB060230;
        Mon, 2 Nov 2020 15:16:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 34hvru0d0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Nov 2020 15:16:56 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A2FGsR1022837;
        Mon, 2 Nov 2020 15:16:54 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Nov 2020 07:16:54 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC PATCH 0/1] Enable config.d directory to be processed.
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <a42154ffeb06a21590db01ab651870040597571c.camel@redhat.com>
Date:   Mon, 2 Nov 2020 10:16:53 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <820312BD-099F-4B53-81A3-12E6F4066A5C@oracle.com>
References: <20201029210401.446244-1-steved@redhat.com>
 <338aeb795a31c2233016d225dc114e33d02eb0cb.camel@redhat.com>
 <6f3caf91-296c-0aa8-ba41-bc35d500adaa@RedHat.com>
 <4836616f-3aa6-d0bd-22db-cd7fecf4dce9@RedHat.com>
 <a42154ffeb06a21590db01ab651870040597571c.camel@redhat.com>
To:     Alice Mitchell <ajmitchell@redhat.com>,
        Steve Dickson <SteveD@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=2 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011020122
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 2, 2020, at 10:05 AM, Alice Mitchell <ajmitchell@redhat.com> wrote:
> 
> Hi Steve,
> That should work yes, although I am still dubious of the merits of
> replacing the single config file with multiple ones rather than reading
> them in addition to it. Surely this is going to lead to queries of why
> the main config file is being ignored just because the directory also
> existed.

I would follow the pattern used in other tools. How does /etc/exports.d/
work, for example?


> I also have concerns that blindly loading -every- file in the directory
> is also going to lead to problems, such as foo.conf.rpmorig files and
> the like.  This is why i suggested a glob would be a better solution

The usual behavior used by other tools is to load only files that match
a particular file extension. That way, files can be left in place in the
.d directory, but disabled, by simply renaming them.


> -Alice
> 
> 
> On Mon, 2020-11-02 at 09:23 -0500, Steve Dickson wrote:
>> Hello,
>> 
>> On 11/2/20 8:24 AM, Steve Dickson wrote:
>>>> You would need to write an equivalent of conf_load_file() that
>>>> created
>>>> a new transaction id and read in all the files before committing
>>>> them
>>>> to do it this way.
>>> I kinda do think we should be able to read in multiple files...
>>> If that free was not done until all the files are read in, would
>>> something
>>> like that work? I guess I'm ask how difficult would be to re-work
>>> the code to do something like this. 
>>> 
>> Something similar to this... load all the files under the same trans
>> id:
>> (Compiled tested):
>> diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
>> index c60e511..f003fe1 100644
>> --- a/support/nfs/conffile.c
>> +++ b/support/nfs/conffile.c
>> @@ -578,6 +578,30 @@ static void conf_free_bindings(void)
>> 	}
>> }
>> 
>> +static int
>> +conf_load_files(int trans, const char *conf_file)
>> +{
>> +	char *conf_data;
>> +	char *section = NULL;
>> +	char *subsection = NULL;
>> +
>> +	conf_data = conf_readfile(conf_file);
>> +	if (conf_data == NULL)
>> +		return 1;
>> +
>> +	/* Load default configuration values.  */
>> +	conf_load_defaults();
>> +
>> +	/* Parse config contents into the transaction queue */
>> +	conf_parse(trans, conf_data, &section, &subsection, conf_file);
>> +	if (section) 
>> +		free(section);
>> +	if (subsection) 
>> +		free(subsection);
>> +	free(conf_data);
>> +
>> +	return 0;
>> +}
>> /* Open the config file and map it into our address space, then
>> parse it.  */
>> static int
>> conf_load_file(const char *conf_file)
>> @@ -616,6 +640,7 @@ conf_init_dir(const char *conf_file)
>> 	struct dirent **namelist = NULL;
>> 	char *dname, fname[PATH_MAX + 1];
>> 	int n = 0, nfiles = 0, i, fname_len, dname_len;
>> +	int trans;
>> 
>> 	dname = malloc(strlen(conf_file) + 3);
>> 	if (dname == NULL) {
>> @@ -637,6 +662,7 @@ conf_init_dir(const char *conf_file)
>> 		return nfiles;
>> 	}
>> 
>> +	trans = conf_begin();
>> 	dname_len = strlen(dname);
>> 	for (i = 0; i < n; i++ ) {
>> 		struct dirent *d = namelist[i];
>> @@ -660,11 +686,17 @@ conf_init_dir(const char *conf_file)
>> 		}
>> 		sprintf(fname, "%s/%s", dname, d->d_name);
>> 
>> -		if (conf_load_file(fname))
>> +		if (conf_load_files(trans, fname))
>> 			continue;
>> 		nfiles++;
>> 	}
>> 
>> +	/* Free potential existing configuration.  */
>> +	conf_free_bindings();
>> +
>> +	/* Apply the new configuration values */
>> +	conf_end(trans, 1);
>> +
>> 	for (i = 0; i < n; i++)
>> 		free(namelist[i]);
>> 	free(namelist);
>> 
> 

--
Chuck Lever



