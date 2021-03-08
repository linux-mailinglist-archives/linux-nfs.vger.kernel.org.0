Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19616331834
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Mar 2021 21:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhCHUKd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Mar 2021 15:10:33 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48118 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhCHUK0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Mar 2021 15:10:26 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 128K5nSU152483;
        Mon, 8 Mar 2021 20:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=stXd3kcpTuUuGp5j6OHv4mkJMBFZOJjgOt79Nu7Gsh4=;
 b=EBUjRng2oAn6yhjZD7awFMcR4ufa32zhLeSXTGj+Rfqehbo/prTYLXqIswqzFN1sviLR
 mhQ776eiwMbwIkiP/8fjWH9PgeU/ANURe3qA8Oe3EYnGgArWdnBoqDCiQ4yU/BiSDWDk
 3haBs/P+mtXzz1layqu2T2NxOFbbNG6t767VV9Cqop20Xy/omIJFYk81gX4FQPSc/0sF
 SDlQ3PFRB0b4Tf0FMzf5xvPbQCehRnJUcMNe21yG/BlIIs0dRPokkgJ+iFQ4HmllfvHC
 7hLdBDfMzx8H9vFJ9ul+k9QCJwLGGi+RZP0iwfoM72aJb1H1mObF3UOWrsH1u29aKUrS ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 373y8bn3ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Mar 2021 20:10:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 128K5Qni185574;
        Mon, 8 Mar 2021 20:10:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3020.oracle.com with ESMTP id 374kmxf3bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Mar 2021 20:10:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2bgdmL6QiO+neagRIJvYmtKpFZqhwP2ZwXJtoGDN+Z82ZzI+d7y7DuzTjYKstVdl26NKXi4WyNAIyGu687ZX5bWyIqSWz3/bW+gZwMe5b1IF7Ss4aoe5uYWfA3fURRhExRQREn4Pd6Pc9w5aEePZh9vp1yMBAqI7k7d+u+PpWkCftl5sPiBjyp/09DQw2w+aIyehhDSpfXxyjvOP+a9NoSxrkxaMbVf7TlDdYwzf8p7RPyU9ncVhFlYIzDosVLZ1iXzyBP/UyGML0JFqKM7e0NX10b42iZ/nuyCgOYv4BG3zu3nTUmxhidHSU9XLITvC8jSnylXX/qzxWND4aMvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stXd3kcpTuUuGp5j6OHv4mkJMBFZOJjgOt79Nu7Gsh4=;
 b=Ku9ocqzQ8As0E09VFnsXcly0C1IK6p2UOk4m2qu862N9nGafVL8ZS4pVINcT9Iegkqt2n6mK2FREvusavtLcxBXgB82esAx1OFkTGwzmavX7K5SLklseuL7tNUkUifaQRSvG76T10ZPdUnDW81Vvay0OZU9A9539FHKZW5R8lH6G3s6x3RfhwQOsD2I3V3KUoILpTahxGoTAlTKmnRHde8u5+7w4dNTKeInJDstGiZFdm6LEhw9/BPZXjo2KIbNp4lWTcZ4BLA6Qi8yByJwxdiou5qwWqnBUdGEQI4rtLSzVqcrVPehqxk6d9UYGHtx1BG68lnAWuefxNX2DGywJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stXd3kcpTuUuGp5j6OHv4mkJMBFZOJjgOt79Nu7Gsh4=;
 b=cJgjdJqk9ubyypWLXQ0LWuKpDIYTOOos24OwCQInX1ipjjrVGC3ja2uY0Gc+7aqCNw8OqslHAtSV98ZfEVQzSwdCpnq1+IZSHnT0DKGwJpRgeDrG2QsTMvUbdl90PiDG4JKxc/cHnoFDUbrLXEW2Mgcs/0HquLPqKOxmaXt8duY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2965.namprd10.prod.outlook.com (2603:10b6:a03:90::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 8 Mar
 2021 20:10:14 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8%7]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 20:10:14 +0000
Subject: Re: [PATCH] NFSv4.2: destination file needs to be released after
 inter-server copy is done.
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <20210302194659.98563-1-dai.ngo@oracle.com>
 <CAN-5tyHr6VEfBubU_gBRyCfzkAzGkwiBvO-0S9Kbnpj_LnVdQQ@mail.gmail.com>
From:   dai.ngo@oracle.com
Message-ID: <4d18eb5e-b1b8-7f26-85b9-b6f9e1b1b231@oracle.com>
Date:   Mon, 8 Mar 2021 12:10:12 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <CAN-5tyHr6VEfBubU_gBRyCfzkAzGkwiBvO-0S9Kbnpj_LnVdQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::34) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-148-184.vpn.oracle.com (72.219.112.78) by SJ0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:a03:2c0::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.16 via Frontend Transport; Mon, 8 Mar 2021 20:10:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19d31788-5335-48cf-536a-08d8e26e2f73
X-MS-TrafficTypeDiagnostic: BYAPR10MB2965:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2965DD374FB26F643E8DA4DA87939@BYAPR10MB2965.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66TyfC37mWILpsjTD15xQrVUYsqzcHsfN5vyOJHdu6X5zsKhpxxwHNtw22/EXYUi51HfYHPOo1NPaHl9bAMsKV9biYPVr1JTZGbSW17ySgm3wZowsYyHif2vs/DFGMLiZ7pYKj2pnMUDPBH1qZDddx5w5b8hr0wmt74YikIBqTyW+Y82TCqW9oUGtD+/Aj7NHpF/U4YTei3tg8zlfDcT0nXbIIptngmNCE2wE1znGkNjVFEhZqw3yEwfjNcgNm1QEgYR07R6qa705K4/rdHTFXwPCwi6CvDFHOO1eZ9qn6o1mKmHZOClauvdtmjFx8pztcoWUPIZrS2SKlx8RhPEdLWxQ07DioToK2BuCvZD9SxdO5cjTtnRrpAQM5iPnxpQOrwI/71aSiwxJw2t6pU4ce1IDJct2sR/zXV2o9VFtm0lFuQqS1cymAIK9dwesbUXRPVfjzNycu7YITxYuQGz8d+BdhYbCj7tXBmj6iZZ2M2zQ4LbYfatINI75XzwV6IUfhRXr9WCDsTFoIuJk7IRo3zVgFsDqG87+MfwElxRkOt40qD5mjBl6C9Bb9iO6/FOnCcOih+Le/2xjrPFm5ScQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(366004)(396003)(346002)(2616005)(316002)(66556008)(186003)(956004)(9686003)(54906003)(2906002)(8936002)(83380400001)(53546011)(26005)(6486002)(36756003)(66476007)(5660300002)(478600001)(86362001)(6916009)(31696002)(16526019)(4326008)(8676002)(31686004)(7696005)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TmpjaHFHa1Z4cjRyWUZicGxtYVFpNlFJQ01EclY1UDVBUGRJd2JYc1FkN1FV?=
 =?utf-8?B?MDg4cnBYZzB6OXcvTHJGOU9JZDhHc1NLbmRiMUpWdGxHR1FjdWZsQzUrMXpY?=
 =?utf-8?B?bWYzbjJPZG1xUHdYZ0dKRTFPODRRRzExclVBUGZpbFRGQmdxdXZlSUxQam1H?=
 =?utf-8?B?MUxkM3lGaVgyb29hVS9KVG5TdXRGVUF4emtwYkRqeDlSMUlUaHhUdWRPYWMw?=
 =?utf-8?B?TC9QVzlNQTdvMG9JbzJTOVZtUU81TzQ1N3NyenNTMFV6TENMVytQWkc2TVF3?=
 =?utf-8?B?L1dzdE4vd1BJeU55K216MWV2UEhFTTNXeU56NC9YTkI0Zjd3cXNSMnlXanlW?=
 =?utf-8?B?WG5mN0JhV0hGRkJTTkdEMHFqRTVPZUw2THZRc2t0VTM2U3pOMFFKaEVzQVBU?=
 =?utf-8?B?VkNtbTJrak02Nk8wMVBtaGYzQU1NUFk3bnYxSGJXVnJjdmVleGh0T2xiN212?=
 =?utf-8?B?TVRFdWhqTGNaRENKWlNnRCtMWXByTGpiQktqOVZUa0NjZGdmdkFMeHFheW1N?=
 =?utf-8?B?YW1kL1Z4N3AxengxcVlaOHRscmhFZEw5MHJPNG1seFVhRktoVlF2cWQyMWNG?=
 =?utf-8?B?UVFxUndhc2VEVVJlSUNUUnRWeTJrQ0dqdXd2bk96cFF2OWduU2RMeXY5ZzVy?=
 =?utf-8?B?eEZCS2NCVjQ1dHVhMUpsWWlERnJLN2tNL3VJSG9aSHFaRVl0VEJENlZ2SGNS?=
 =?utf-8?B?UWVqMVRVYVV1T01MMi8zNXFxZmhER1JMK1d2SVJIWThpSW5hK2lTNTEwRU53?=
 =?utf-8?B?QWV0ZklVV2VxZU1VN0U1SEdmdU1BalJTZFBpSEJmWHNKTmJ2VUpEVVNSQkdT?=
 =?utf-8?B?QmlLNlBPSjQxVUttekE1eGhLZEdBbU1wYy95Yk5FZ0NVaTVxcU5LWUZobXNV?=
 =?utf-8?B?RGhIbU5KaVJ1aUIzOFdsNmZOdEhOL2VEc3ZiS0Mrb2lpL1NDSTByd0l4NE1O?=
 =?utf-8?B?bkpoOTROYXk4WnppZEZ4LzY0cnFHbUZvQlQ5L2tabUpGUUwrTllhTHJERHB4?=
 =?utf-8?B?VGJWUTJHOWhkR2R1VncvNWdSVWpYcXRnZjQ0WFBkbGlzQjJHMnBqaFNpVjV3?=
 =?utf-8?B?TWlZaFJDY25XRjladVFuaVNHbVZGaWI1UXhnTGh5YlZyWWVtcWptSHYwaVpr?=
 =?utf-8?B?eGdJeXpzTWIwK2ViWWdPUzh5NzV2Mkc0UEdUZGpiMlgyM1MzdER6MEV1U0lK?=
 =?utf-8?B?VGpzb2pLbTZURHhTalc5L1krREZQdDBJUFc2a0p2M3JWakM4OEtMN0ZQbjgy?=
 =?utf-8?B?N2pobHAwS0ZLa1BWbDhqdC9NaG9YejZ1dEt6YXlCNk42YTIvc1F1UXphQmRU?=
 =?utf-8?B?aWNvQTJOWENBV1RmTmdmM0pFUU9jc08vRkR1R3lOYWxTRnJ3dHA2MUdTakhv?=
 =?utf-8?B?K25HcEFxeWdieVVRRlpPVFJ3alhwSnliUXE4YjFWSGtNb2RkTXFWczFpOVFl?=
 =?utf-8?B?akRtRWZlVklHeGJRdysyVngyY3RlV1g1dG11SmRSOHlkQS8yNlRhYmpWREVN?=
 =?utf-8?B?TWVoWTNNYWdTSS9hT0ZaZkNYN1pRWlh0RUVCbk1KQjhDRXMwWGZ6cEhCdHMr?=
 =?utf-8?B?bE1mNmt6bjBrdGRqR3F6QlVuN2FTb2VjNzZvNm44cHl3aGhoc1VqTzREODJp?=
 =?utf-8?B?QXAzTjJva0FvUzdXRENZVmFpRG1nT0hEdG9jQVdGOEtQb3Jta2J2NTh6a09D?=
 =?utf-8?B?UlFOVDVpeDhaN1ZwdXhpWEpIbk5wVU5uRW5DMVJXYVNSVFowTkxjaDRjVzha?=
 =?utf-8?Q?zBLGCuUBmGigQAwaznxzY5OD0Jp3VKjPNCr/JhR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d31788-5335-48cf-536a-08d8e26e2f73
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 20:10:14.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qsM+xynK7ogSqdtjXN1PpiynrbLCn4f7nGrZZ1TwdyaDheAqc5bkyCrvHCY7UIAiWlwe4bWO7w+VH9CoptdjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2965
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9917 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103080104
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9917 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103080104
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks Olga for reviewing the patch, reply inline below:

On 3/8/21 10:35 AM, Olga Kornievskaia wrote:
> On Tue, Mar 2, 2021 at 2:47 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>> This patch is to fix the resource leak problem of the source file
>> when doing inter-server copy. The fix is to close and release the
>> file in __nfs42_ssc_close after the copy is done.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfs/nfs4file.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
>> index 57b3821d975a..20163fe702a7 100644
>> --- a/fs/nfs/nfs4file.c
>> +++ b/fs/nfs/nfs4file.c
>> @@ -405,6 +405,12 @@ static void __nfs42_ssc_close(struct file *filep)
>>          struct nfs_open_context *ctx = nfs_file_open_context(filep);
>>
>>          ctx->state->flags = 0;
>> +
>> +       if (!filep)
>> +               return;
>> +       get_file(filep);
>> +       filp_close(filep, NULL);
>> +       fput(filep);
>>   }
> I don't understand this logic. There is no reason to call
> filp_close()?

This is to follow the steps done in nfsd_file_put/.../nfsd_file_free.
However since this is the source file the flush is probably not needed,
just there to be safe. I will remove it.

> All this would be done by doing a fput(). Also fput()
> would drop a reference on the mount point. So we are doing this then
> we can't call that extra disconnect that was added by another patch.

nfsd4_interssc_disconnect does not need to access the source file.
I tested both patches together and did not see any problem. If there
is use-after_free condition the code detects it and there would be
warning messages in /var/log/messages.

> Anyway I don't see why there is any reason to call anything but the
> fput(), I'm not sure why __nfs42_ssc_close() is a better function and
> doesn't lead to the "use_after_free".

Since __nfs42_ssc_open was called open the file, I think __nfs42_ssc_close
is an appropriate place to close the file.

-Dai

>
>>   static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {
>> --
>> 2.9.5
>>
