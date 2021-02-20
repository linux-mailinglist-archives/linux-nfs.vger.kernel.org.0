Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9DA32027D
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Feb 2021 02:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBTBcv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 20:32:51 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35578 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhBTBcu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 20:32:50 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K1W3Qq116761;
        Sat, 20 Feb 2021 01:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vvU9MqTIvUgdqA0vw1BNRPez2MfTBhV/uCAPUObqA6k=;
 b=ChwtC7fkzCQUkivBPKV5jYs2Ikte2NEswycn8frxtaYmGFyOHQjz3o2xsuk5lwPt7gNq
 XW/yBcIGA6XgWsi26hL9lVkb6NP+BcihRYweCcogcOSv/BywwUbUtvAJ+GMISrOO17nD
 Kvrk/bJaBeg8VpNEYwjCLOK/wLWCBPN4yqWItHfA5MBFNkmX+kpU55+KGuZQvIzwylYm
 vCWlag8LYEtrO1TjtFDEP6qsihxTLsgUaWfwjSGpkWrTBtaOUysQnZpoo52AJ06FTVq0
 0UaqjXoJdPmHBuJ0/llLCvatXbY0fvCrtAl3cy8ino8lw1G0vKmJzM+DEvrjVb4hNeFW iA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36pd9ajpwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Feb 2021 01:32:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K1TobZ007950;
        Sat, 20 Feb 2021 01:32:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3020.oracle.com with ESMTP id 36prhwayy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Feb 2021 01:32:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZJOqwr1xm3QHVYiXXDOZuHVVcXX39OXoV7hYI6ZJZm4F4usf9TnDDrbz8w1OYKmI/luhnhbEH1ADhO6IS4kS4+LNjjuCxDEqQVSwgm4g2I/0eMrpQ1iIr9tawuCXZyP5An7/DacD1JlUZW3Wj1EUq1b5GWuB8Z1qDqSJ/7lla60CYnIkFE9w8CJWGM3nsAcrVymk3M33t0wFEOsiPwb5V1oElaJGkJhsffHY1d92UmO51M02jvOeqi3VPK5FS4u0O9KoVivdNnprbcOq74V9fqPLtIBO1D65bPhjJgQS7mix9T0elgjSXjVJ5+F1ipWuR+THeHAKkPD7aeDbKnsxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvU9MqTIvUgdqA0vw1BNRPez2MfTBhV/uCAPUObqA6k=;
 b=aWmAV9E/E3S8/JnSK+JiCCOSYjs8DJN5kOeqUiePpT/qEOsgJbu+zzn7xl9eDEiKn1oYQutBvXyMD8I01GFblmLw6FNzYGxVWQVW+s3BcBKiXgvrZ6XObQPWqza6EJADKwiZKEKOgNkHN/MW/zC+pGhezGHhntxcbiEauCxJ9Pmql9CTDYwsPwzxyk/z9gJ/cqq9RjXS8UxyEJ4/ia2d9Ykr6wFOxmcAPPX4e7DY6ZVkIJHd7E2M0+cKuRDP0ExApMSHbaAlBw/9lFtOptkbkTi/d2JlSoN4A84PMAyvi127Lkce90v6OlcrBNAvGdgVTJrzsIiPOv3Er38RU26gTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvU9MqTIvUgdqA0vw1BNRPez2MfTBhV/uCAPUObqA6k=;
 b=eqbntgQet/FdZsZIjAqbvCsjGKZM0oRgIGS87yk+w+5HSbzIl8OftmupKBSqd0lT4gp753h23n03bdQ6Mt8Ui9DLPc3WmpmBGVwzNy/h0VoYFdjDBroSnmGmmz8ssWUQ521PHFcWp67glFFW0qX5wsbsPKXhfu2obJBMExB4wI8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN7PR10MB2434.namprd10.prod.outlook.com (2603:10b6:406:c8::25)
 by BN6PR1001MB2209.namprd10.prod.outlook.com (2603:10b6:405:2f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.42; Sat, 20 Feb
 2021 01:32:01 +0000
Received: from BN7PR10MB2434.namprd10.prod.outlook.com
 ([fe80::20d8:7ca1:a6d5:be6b]) by BN7PR10MB2434.namprd10.prod.outlook.com
 ([fe80::20d8:7ca1:a6d5:be6b%3]) with mapi id 15.20.3846.041; Sat, 20 Feb 2021
 01:32:00 +0000
Subject: Re: [PATCH 1/2] NFSD: Fix use-after-free warning when doing
 inter-server copy
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <20201029190716.70481-1-dai.ngo@oracle.com>
 <20201029190716.70481-2-dai.ngo@oracle.com>
 <CAN-5tyFnTSuMivnBPD9Aur+KDxX8fCOuSaF7qGKe6bFB7roK6Q@mail.gmail.com>
 <20210220010903.GE5357@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <69ea46ff-80d1-acfa-22a5-3d1b6230728f@oracle.com>
Date:   Fri, 19 Feb 2021 17:31:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210220010903.GE5357@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::33) To BN7PR10MB2434.namprd10.prod.outlook.com
 (2603:10b6:406:c8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-163-7.vpn.oracle.com (72.219.112.78) by SJ0PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:2c0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.11 via Frontend Transport; Sat, 20 Feb 2021 01:32:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17768394-40b0-43cd-9514-08d8d53f51ea
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2209:
X-Microsoft-Antispam-PRVS: <BN6PR1001MB220904C47895FCF8E48824B187839@BN6PR1001MB2209.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJExibSsrtJj5mIO6Ph8IgQS8Cqn61nk6lBG3AryBZTpM3qtyBOq5ZuFi2ORbbN4D/sKyFC45VbPkF4ptI6wcARaM1Hf3nSKYlOR9HjCqTLHZ7BAX61pvZ0e0dA8aEWSTupgJ/j7lpOQQZQz3ORqnY3xapST79fsakkQKnBcUDhlliKGHzfiLS5cg+EYAgQ7SzefsJLV39N8COfgTFZAHkr3qV5uHIQKxf3t1AjF9bjvaMFAjjOY0hhtPGmJFsB180L84oXv+qXkcIyXJC1KDl7WDsVOjMBzHcyG3bsJ1RFVxOwoVUmUTHwyKO/NeXXRcHG0W47w5zCGI6vmO/THgqZ55ygRTpRxNPOQKtWtPZq0IzPyROuOrDmmKHmp4MMF8C/97eDWTpd2+YqSRIuvksOe+iNGnZTCTpuK/XCG8sYKoOMdADSa/LBw5voE2S0tIbnk+Xs1pS6/dzAChj4kPrkjY1OGmVsetVXgUTCJ5mzsuErdKF/R8afVTrTlNSIYXaJ8fQPPB0XwcwdF8+a2v7gqvSQ2XPuMCa54tZ5lmvD6Wj400HqgSMfKrs6OuJhTa4/RWyMzUdNRMcJ2wv7Ppg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR10MB2434.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(396003)(39860400002)(136003)(9686003)(53546011)(83380400001)(4326008)(5660300002)(2906002)(7696005)(36756003)(8936002)(66476007)(110136005)(2616005)(8676002)(316002)(186003)(66946007)(31696002)(956004)(6486002)(86362001)(478600001)(66556008)(26005)(31686004)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OGdzMjRaVVFNaCtpUkJLUHVDU2pteG5LSVNsUG1jMUNqOFBHRkhnMVR5K0tZ?=
 =?utf-8?B?R3Bxc1FlcXpkOUw0QzdXV0E0bld1QWFpZFNKeUIwUm5wQnJ2bkYrTW5ROER4?=
 =?utf-8?B?aytZb21GOUdCb3lXdC9Rc3QwSS9YU1VEZUZQZndzckZ2WCtFSy8xZFdDVXp1?=
 =?utf-8?B?Z2ljekx1aUpoTE45cDBXY25SeXVpcHI4cE5KVDZFS3JQc0VRcEQ1b1o2dUEz?=
 =?utf-8?B?UWtGUVRFYmZ6NW9kN1Nyb09ZQnJ3QnBtS1NSSE9SSm1CbEljQjA4Y0N6enJy?=
 =?utf-8?B?Sy9UNmRJQUpCR3NDWVcxaUJ5YWk1aVcwc2E2cFNrWjdQbDVWcFRpVzJ4cXVP?=
 =?utf-8?B?amptbnF1M1NFV2F4SGFhM092QXo2Qnd5TEh2TWxDY0NKaHN4R1UvQndiSFVy?=
 =?utf-8?B?Z1d4Mmc2Z2drKzRIYjBNUDhVTlQ5YXZwTUM4MkdycUhQTGI0N1lIM3dQTWZh?=
 =?utf-8?B?NWhQZ04wR1FZMDgrMDgzaW5obEdmU1NtNUp4eDkrSW1ZMUt5QVdtVFA4RlQv?=
 =?utf-8?B?UWQrUDMrK1BuRllzc0ZwYWMwK2pTM1dCNnlRSHhTU0dhdElVdmk2MGpYSlVj?=
 =?utf-8?B?ZVRoeVBOeTMyYzExeldOTE5pRWE0ZWVQa2FXZGs3RkFjTkMraE5XTk80U2Q1?=
 =?utf-8?B?UFpwMzJpRk41aFdSMmNNNGY0dlVXeHo0dW5jYTNOZ3d3ejBlSk9XQ3Fuazdk?=
 =?utf-8?B?RkllNENPRk5IRURXalp3YjJyTkRuRkYzL09LdldaWmY2WktQM2tzci9tNlYy?=
 =?utf-8?B?RmRGMGVxYWtUTTZmRGptbCtPUTNCVjFsaWl2MUJKYTdlS1BBVWJMSHY1cWlZ?=
 =?utf-8?B?dlpzZHN0bXR3K09ENHE0bm9tR1ZnbjJNdUx0SStzcDd6QjVJY3VIR3p0K2Nw?=
 =?utf-8?B?Q0dUTFNINUlaU0RKR3A2UDRjbmxiU2VxOGxnMjBSdzdQenFHS1VQeGRpNy9M?=
 =?utf-8?B?YzJTZG1tV2xEeVhqd2FiYVVwL0d4OUI5K1NvMkgwZnhzQnZGUDBjS29PRlQ0?=
 =?utf-8?B?RHlMS0JON2FjWDZHTjRPNzU2SlYxYUNDS0xMR2UzSWRJdU8wVWdqeXRuczcx?=
 =?utf-8?B?M0hReW55TDVncmdiLzViay9OWXlsY1hSRU9jcTZqZGQrMXdVMDI3dEl1N0g5?=
 =?utf-8?B?T3kxcHNuaThPbzVOZEVmdVVuZjJ0eUZXN0hxcDZjdzR2bk1ONHJqdDc0aURo?=
 =?utf-8?B?SDZQNHN0QzVZVm1EOWhDVU0yWGZqc29tWi9Qc0VZY1dzUktjc2xUV1ArT2k4?=
 =?utf-8?B?OXkrc1p4RkZYeGdaK1BZa3NOSjg0N04va2s0REtCUDRaOUkvY2hMeStkUGVF?=
 =?utf-8?B?OFQ0c2QzTWpuZjgzQTVjMTdNdWIzYS9JMTBWR25STExQQVNJWGQxMlNjNGdD?=
 =?utf-8?B?ZlhjbjJoK25HYzhlOUZDd25ubVZMcFNaTHlOdjZYK2owaVdsMnhZYTBoc2Fk?=
 =?utf-8?B?YmxxK1RQQTRGZEJHYWx4Qk8wcXZSMi9SYlorR0wxMGdCR2tQeUxFU1RYaVBQ?=
 =?utf-8?B?SWtmV1l1bGVxLzFJaGIwZmpsZWVjOERjaHpjTm5pSmZEY1BoSnAxaVdxdyta?=
 =?utf-8?B?OUNPUkVjSG5PbFZlVkk4aWJNcEFiVjIrbkFVTXdic21sbXBmV0tlTVhic2Rr?=
 =?utf-8?B?U2dTSklJYzdINFo1NE9oM3RXaDhKNmNJcFJmMVV0N2U0SnNRU1BqdG1OOGxR?=
 =?utf-8?B?OEZ5QVhIWGh6Q3BVd2FVTDhKUldLUnkxZ1VkQ294KzJNYUpyeG5tYkNmR0ZY?=
 =?utf-8?Q?6E+DJUdn2E1Mylzd49jiKhSgSheiHtmYwmHNhCt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17768394-40b0-43cd-9514-08d8d53f51ea
X-MS-Exchange-CrossTenant-AuthSource: BN7PR10MB2434.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2021 01:32:00.8618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhJ7akZO+RhIf8zIwL2aAcF9nqTdClQbx6HfboeZLYfaGqUU2BP8eXW8kjvI+LNy1c+7B0Fwyi9tE0Ya3sJKiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2209
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102200009
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102200009
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga and Bruce,

If this is the cause why we don't drop the mount after the copy
then I can restore the patch and look into this problem. Unfortunately,
all my test machines are down for maintenance until Sunday/Monday.

-Dai

On 2/19/21 5:09 PM, J. Bruce Fields wrote:
> Dai, do you have a copy of the original use-after-free warning?
>
> --b.
>
> On Fri, Feb 19, 2021 at 07:18:53PM -0500, Olga Kornievskaia wrote:
>> Hi Dai (Bruce),
>>
>> This patch is what broke the mount that's now left behind between the
>> source server and the destination server. We are no longer dropping
>> the necessary reference on the mount to go away. I haven't been paying
>> as much attention as I should have been to the changes. The original
>> code called fput(src) so a simple refcount of the file. Then things
>> got complicated and moved to nfsd_file_put(). So I don't understand
>> complexity. But we need to do some kind of put to decrement the needed
>> reference on the superblock. Bruce any ideas? Can we go back to
>> fput()?
>>
>> On Thu, Oct 29, 2020 at 3:08 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>>> The source file nfsd_file is not constructed the same as other
>>> nfsd_file's via nfsd_file_alloc. nfsd_file_put should not be
>>> called to free the object; nfsd_file_put is not the inverse of
>>> kzalloc, instead kfree is called by nfsd4_do_async_copy when done.
>>>
>>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>>   fs/nfsd/nfs4proc.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index ad2fa1a8e7ad..9c43cad7e408 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -1299,7 +1299,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
>>>                          struct nfsd_file *dst)
>>>   {
>>>          nfs42_ssc_close(src->nf_file);
>>> -       nfsd_file_put(src);
>>> +       /* 'src' is freed by nfsd4_do_async_copy */
>>>          nfsd_file_put(dst);
>>>          mntput(ss_mnt);
>>>   }
>>> --
>>> 2.20.1.1226.g1595ea5.dirty
>>>
