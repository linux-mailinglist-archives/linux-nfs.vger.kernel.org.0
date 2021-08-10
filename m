Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D053E8698
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 01:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhHJXg7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 19:36:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12280 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232057AbhHJXg7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Aug 2021 19:36:59 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ANZrZU018579;
        Tue, 10 Aug 2021 23:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : to : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=/74aUaXNWulJodkidpQXT3xwXg/5SdlclweSL/f2E1Q=;
 b=KbJTAvpJa5Z2ER3GAmmAP85NTBvA8d1qsdMQfgFcq+4TtkbM0zPax6jWmPH5TgP8mWPE
 4wk2a81NISb9uIjUn5upf5TwRHFD8yWb1T2IARxCEVSu7eCeUKZi3f1FCAT4JUUC66j9
 gaivIdcQ/0O2c+/PTACzxSeh6HG1qNjhzyEXyuddFDDPAdRedXIFSfxSGEyKtpEIlY7Y
 SKwJgiJY1N9thMQMgoG8JGq9w/Swqw2PSRo5ndZCiHU7BbW6+aUOEs/QQjJzMlU3Nns4
 5oNwANoxjnkDOPy27TxfI6AHc64dIE8syjAaXkBPu1LCrmj/yql6CFzEeLKFyFdphZcG rA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : to : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=/74aUaXNWulJodkidpQXT3xwXg/5SdlclweSL/f2E1Q=;
 b=CgPkLdzzLX9oMXglmMXLpz5qFLHL2LtEdUvwtwirP0eDdcibzvURklq+1AoxLLivDLrz
 FeYSE7WspZR1eTyWEnSJmqXKfA28erxdJizfU9rTZ54B0yTk+UAVpMUaJ3ZpcZbYhovb
 y20ByewyrDNK2yKk2Bc670AOFMCjRiId2bqLbZgGdTdLVWyaStWnlLQTRD4u2JG3KuXS
 IW1r0PxU9qu1d7+06Ws8haaKqBvwt3ga7oLYaJDESA6DGgIoO27hvKbv98kLva/Yx24Q
 t/+ccC1bRc6D2Ls2V99MNewP4erLefwFMP6CwZWqN5an7CAMf8MfZI0c5TIakXwlMxUB Ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aay0fw5tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 23:36:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17ANBasD138973;
        Tue, 10 Aug 2021 23:36:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by aserp3020.oracle.com with ESMTP id 3a9vv5hgae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 23:36:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJ1pJd0xM5pFddIHdt1KfKHESfxQNLkggjbZe79GIudUgdQiduwbhpCmH+KbqgFAfDMlVh+C9CESO1EewZ2vYWeekSBKjNiueZL5NtYZSEeYDnx9zYacV+5K6bxmgRU8yciE8j3g4vz0lYQb3BZrtxJtywTc/7IH5TUVId6jJ8Qypnd51YmOLAz+Ee5+dyOjG/w+PgLhTHYwtytI8vJGEIICeK8XqtJtMf2VFlyVB3kNHvaV444StVNxL0LbpvcyK8Xz/XEiN4oz6OGnAHbmU8kCyVvrDQVqtv+1BMb+qbsx5EqQuKEH46sA7cXBH6XlPpnhMucZyXZ3uW+qNaglWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/74aUaXNWulJodkidpQXT3xwXg/5SdlclweSL/f2E1Q=;
 b=dZZ1SZGu3L14nPX9e7hyhklopTbwtLVhj5dm2kphxkyxQyHVt/fc0VAKdBhL7CxnpGDFSi0ZS9aOp1z1TB/i2P+Kj0EW7Q79EUgxJuZ+9j1y9xXKrNJEm7KBXv6+mSDT6UGvbQFafEzn0yOK0dB8dPH0yjr8hQgRYVTi8fks6Be4aa8N/oADICFKxI4cwWgD1MMhXs97WsTSuGj2ZSYvoD/pkI7xahMenJKmlfl5rwXs/vpcTOqefMh43hDmVGa8hKvfnNggdETk+JsnkQa4cZ04rynwDjMFONCeKF2SSsUb8UvXS3bmgzhVBNjVIPk13zhJCX8j4zAJLlR4mz/2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/74aUaXNWulJodkidpQXT3xwXg/5SdlclweSL/f2E1Q=;
 b=fEMRk2o32IaD6iKGUI/rVbFmJOzagb20ObxIMSnbdE2oMnRJNaskz3hrFDF/FMo5/WqR9IuiJgY3ZQpyE6JCVIK1g774Nmw+lTYXVTQHLd10qUEdu+nk0yPzPpNEkFA6kI1iBJistFhuYuo5/H4NQDa9zlmXzPNTD9zT6lIOrsc=
Authentication-Results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 10 Aug
 2021 23:36:31 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::4c6d:c359:aba9:87e6]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::4c6d:c359:aba9:87e6%5]) with mapi id 15.20.4415.014; Tue, 10 Aug 2021
 23:36:31 +0000
Message-ID: <2460b04f-c699-971b-2b44-f6ec059e3b58@oracle.com>
Date:   Wed, 11 Aug 2021 00:36:26 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:92.0)
 Gecko/20100101 Thunderbird/92.0a1
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Language: en-GB
To:     Trond Myklebust <trondmy@hammerspace.com>
From:   Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
Subject: =?UTF-8?Q?open=28O=5fTRUNC=29_not_updating_mtime_if_file_already_ex?=
 =?UTF-8?Q?ists_and_size_doesn=27t_change_=e2=80=94_possible_POSIX_violation?=
 =?UTF-8?Q?=3f?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0155.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::16) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.254.15] (84.71.130.115) by LO4P123CA0155.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:188::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 23:36:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a028f38-28b2-4741-c995-08d95c57aeaa
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:
X-Microsoft-Antispam-PRVS: <BN0PR10MB5143450AC8D36BFDF8C411ACE7F79@BN0PR10MB5143.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2C7chdjfe25zgaovFjYdLmMGs+KJKoQLJutGiFR9RzFHDzHTqhMzOuCz/6v70VK6d1qhCuvA21Yayy+TrazRFiqKDPdjAdqyMF/7Ejni6FsQb8IVqF3VDnmsL2dLjfZg68k4JvAhcZRSQv8MmfG2ejwE7m9A8usSuIQu9D5NSXzONvyiMQn3Gcc94aXnZv+ZrRgMJuKKrB3qKo91YUFF/I2gVmmyaRbewUgCugZ+Dio79taQFYZLk5aGyxyisHqaSAQARLoAI/2piFfemzwvXNbN/7lMJahhOBjGSavbotfxi67ZUfujZmsbyOjpcSrXC2anTmZ9cmnNw4DZYzLrTci/RFvF8ILbsBFYvLy2vh0EdXce4730sI/Fpp4nwjqLjw1nQAQFSWJxwb5ImW5OtAy6LwPT1qNdR/7v3sJz4PUs0Are76DuQWpXcemuBBvEN49bVLUFc9Q3jyNCiJZCRdcfuwIkUi7YMCJNH/ireFf2UryiTWvBgrwLMcyOStRwcv6Kd7mAFsD4QnEQRZFCoufWLGOEf3hPf6inNBMmNAz9F4E/NnCHZ+8q+238Utds9JT9YJMxE1AHyrI5qistt0k8cnCTS36laswDYblUaTrHUCxbfOjZj/jRHiWND3mKOSN0DpgomQtXnTowFgyFkrLptiyI3W0YI/C5vgS3oNxoLSoRvt0BbQ6EXjZw17sZ4nDt8BCRb7Z/zqvq5fWPqUqdaseBTJN78pSBvgmLfR8Kis9n+GRIZcpfmZQ76vnuQeAUlNLjynk4+62Se4qZt5WZcRrXhRqa47rZUAQxeiYbA7H/Wc4w8NJt+wNbmURM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(346002)(136003)(396003)(31696002)(4326008)(478600001)(2906002)(8936002)(38100700002)(86362001)(6916009)(5660300002)(6666004)(26005)(36756003)(316002)(83380400001)(186003)(66556008)(44832011)(66476007)(36916002)(16576012)(66946007)(6486002)(31686004)(956004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VSt6dXl0TEJiZTdNYk1PZjZZa0FJQmIzbEJSWTBzUk1TM01KK3FlQkpGQzVx?=
 =?utf-8?B?cWtYUkQrbkxTbnJQYjFmbUhEUFlPWlNVb2hrTzBWT1BvcUpLUkNCUGNxbmc3?=
 =?utf-8?B?bFZDSXpWaGdZaXRRcTZjWXZFaTR4UThCNVN1Q2dISGhuRTF6ZmlVSGdaV2or?=
 =?utf-8?B?Slg5YW9pUElFMVNtT003b1ROaDAzUktOcHEwSG9VeEFZOW5FTWo2Yjd4NVBQ?=
 =?utf-8?B?RWNIZjVpcDFsL3ZVS3JWWklmeWhJa2ZwZVJYOS9SbWhkTFVGUnFxMFJ0UVlK?=
 =?utf-8?B?U3RHR0lEQkZyVHl0SlZxMnpTZUxLR1BrZTR2dUJyOHlYZjNLZTR3Skc4c2lC?=
 =?utf-8?B?cXJPREFvVXFQNGIvT0s0OFUwaHlxdVo0Vm9DVTcrelNwc3lVVTJjYkFza2VZ?=
 =?utf-8?B?QVhIUlZqLzB0UkxFSzg0TmxTMTRPTmRScGJQUU1iTGpFT1NMbGNyM1AyYmNK?=
 =?utf-8?B?WFZ6ZkNlL05VZWkydlh3SjFCVmpqR3ptOGtEckZVN1NWNEdxNHZBZGVhZUJI?=
 =?utf-8?B?bXY2SkpoeUQ3RmlSelg4TE9CbU9WL29DbmpMaGd6ZVVRN1VYWTFxSEtMNDNv?=
 =?utf-8?B?bXEyNjh3ZjUwRmpZNG9RUFArWlFKUUI1MjlNUHZMU21lT1FiVUVWSGYxcXNU?=
 =?utf-8?B?M04xTzRGVll2VHAyTjVwSzB4NFI5cTRWNklMT3ZWbkNLbUxhTXE1YXYxVkFa?=
 =?utf-8?B?VzVYNW5KY1lILzhYZExLUms5dHk5S0ZkT00ySmpHSUtVUWJSOXVybDhLQURv?=
 =?utf-8?B?SERXWldXRnlraXEwd1BUVzJ0SEpDd2IrL3Ruc1NFeFZ1bnV0WXVJOCsyVnQ3?=
 =?utf-8?B?eEl4VmhCWFprdzZQSzF1Z2ZWc2RjTjFheERGQzNLTHdpY3Q1K0lpMHA1OWZZ?=
 =?utf-8?B?Z1Q5WjhPelNBeXlOQTN1SEVPeVdVK1BEbStUSVB6MEdCcWtrUFpiTERTZDJ2?=
 =?utf-8?B?cW41Vm5HMUc4V3dpODNkcG1qc2ExOTBNai9nekNmRlJsaTdkWDJYcjlNUE1h?=
 =?utf-8?B?RXYvNytVWkx1aElkVzlVN0lTVStPM0cxT1FzN0Y5ZlBaa1JlQnVVS3crVkdi?=
 =?utf-8?B?UnN5WDc2WDBPZWZ1K096a3ZxaVFFNDFZdnQ2ZzR3bFEyTTFRUFFYYytmUkY4?=
 =?utf-8?B?a3kxMVVtVXhzaEYvVlJYakRmMk94NG12dE1GMEY0ZDgxS3ZUQXhoNkdSTmJN?=
 =?utf-8?B?dkg4cmVlRlplS0htSnVZREh5TUp4cnZCY0p4QW1kRWcvTGFiWmJDZGNUUTl5?=
 =?utf-8?B?US9WWjhla05rRDlPclFqSjVpRWRmdFA4dFR1UjlMKzJjZTNseXM1Q3ZCUW5i?=
 =?utf-8?B?MGVja3E5QXlqVlphbEc2MHJld0JSSzF4VE5ZeGJjVTVpZDQ0Nm1ORUdWSnlB?=
 =?utf-8?B?dFZBNDdmOFJYQlpjbmJTTCsrT0RROWpxMEhLUFRaVWVYZXhRUTJuTmZzRlZq?=
 =?utf-8?B?TDI4TFVjTEVBUld1cXE2Y0dxUzlrYXowcmxaUVd3b2NmTWY5U01WUlNvNzdl?=
 =?utf-8?B?ZVNjVERSejRFcHcxdE4xUE53bG1qSGt6Vmo0b2RIZFVaZFBDTk5ORGZsWmdN?=
 =?utf-8?B?ZGlhSDB3bmI1ZG5vc25xc0JxVFpPQjF4VmkxZ0VyRk5ta0hhMDE2VWVKNFg3?=
 =?utf-8?B?ZnBJUERka3M5Q1Y4aDZrVFpYdThVUTRtT0RHL0N5b1JTNTJIRUFtYTdOYWNw?=
 =?utf-8?B?SmlNemMydGlMZCttSk5WeXFWNk5xdkV4UW1DN0hvWmJ3cWFwcXRvbWxuU3lj?=
 =?utf-8?Q?+h/nnQAQ8LRgacjFV4QNMvJ+ex/dQG1aizdlXIL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a028f38-28b2-4741-c995-08d95c57aeaa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 23:36:31.3617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfqXD+0FYauTTjWiOiJeoJI25M3qCRB1xWD+vz2GOIBYLICFUTv88ejmERK675pptUzacFDkCLtiO/dfZEVVzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5143
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100153
X-Proofpoint-ORIG-GUID: Ey8JtGJUD0eT_Xi7t5J0qE22AZQouL1I
X-Proofpoint-GUID: Ey8JtGJUD0eT_Xi7t5J0qE22AZQouL1I
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

hi Trond,

I had a report that bash shell "truncate" redirection was not updating 
the mtime of a file, if that file already existed, and its size was 
already zero.

That's trivial to reproduce, here on v5.14-rc3, NFSv4.1 mount:

# date; > file1
Tue 10 Aug 14:41:08 PDT 2021
# ls -l file1
-rw-r--r-- 1 root root 0 Aug 10 14:41 file1

# date; > file1
Tue 10 Aug 14:43:06 PDT 2021
# ls -l file1
-rw-r--r-- 1 root root 0 Aug 10 14:41 file1


An strace (of the second, above) shows that the bash shell is using 
open(O_TRUNC):

10581 14:52:36.965048 open("file1", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
<0.012124>

and a pcap shows that the client is sending an OPEN(OPEN4_NOCREATE), 
then a CLOSE, but no SETATTR(size=0).


I think this might be because of this optimisation, in the inode setattr 
op nfs_setattr():

	if (attr->ia_valid & ATTR_SIZE) {

		…

		if (attr->ia_size == i_size_read(inode))
			attr->ia_valid &= ~ATTR_SIZE;
	}

	/* Optimization: if the end result is no change, don't RPC */
	if (((attr->ia_valid & NFS_VALID_ATTRS) & ~(ATTR_FILE|ATTR_OPEN)) == 0)
		return 0;

and, indeed, there is no change here: the file already exists, and its 
size doesn't change.

However, POSIX says, for open():

> If O_TRUNC is set and the file did previously exist, upon successful
> completion, open() shall mark for update the last data modification and
> last file status change timestamps of the file.

[https://pubs.opengroup.org/onlinepubs/9699919799/functions/open.html]

which suggest that this optimisation may not be valid, in this case.

[there's a similar issue perhaps for ftruncate() where the size doesn't 
change]


I haven't yet worked out whether in this case it's deliberate, but not 
POSIX compliant, or accidental.

I'll continue looking, and come up with a patch if one is needed, but 
would appreciate any comments?


thanks very much,

cheers,
calum.

