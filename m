Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B76676899
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jan 2023 20:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjAUTvJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Jan 2023 14:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjAUTvI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Jan 2023 14:51:08 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41CC1E1EB
        for <linux-nfs@vger.kernel.org>; Sat, 21 Jan 2023 11:51:02 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30LJkxuX019443;
        Sat, 21 Jan 2023 19:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rSlLZCZvSFAsLsbjMGTbFX8mEPigMVaIwB8xqGw342Q=;
 b=eYx/Q2c2CEzqvsmpWTCM6fv2/qHBrKCfufbz8Q5Q6HIZldSqbrWEXhwGpkzE3gFDYI+n
 qvamdKXs1F0wvF3RSEp93/Ir0Zmtf4Ljk/sBjM6HPsEwXJQSpnFWp6leUJmbhItiuyuC
 DWGVKkM78H7itMhRANFZ/854UGxrvNzbXmHCwRon/0MnIYR2qA+VGZuf53cT2QgiqPBl
 orqrd+ZifZgcBdo769+gBlVG63G4jlobuzk8wita2sHfvgqF9LGE3PSC8YgNxPTALJ00
 Ru+Fo+X9xmOMUQ4e1Qlxc6OLvC57t5qwRYHkOb6AIXZqvgf7BMc9HCQbW5iIEMogZwY5 dA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86n0rr81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Jan 2023 19:50:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30LFZOGw015493;
        Sat, 21 Jan 2023 19:50:52 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g8afk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Jan 2023 19:50:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n24iXzVcT17pVTgO2UyLPMz9XQpmqeprbBAoPH1uRNWSJIEF1xZ/8DUv0xEXzpGjSYj2FsFmL6aonLmg+NzO1kE8ndXqmXIQNM+SDxqFsj1IFSdfh52XJGq0XXBisos5IiV94Pp/6dG3bKh76hZdlhiHW+OmjwE8J5wB90W94Zm3DClGHSpn7U8ZQYEz+2oujX0F4J0LiA+VEDRkSFHAEF+TRJgXA3aPX4mW/5Y9KoNIYSsaXU2R1HbixWkYTxovJzk5hne7twZC8hL9DBOeUFsVMwsnqeHS+8dbdbEs+91T5MdVNbIG694aEVu6dJujXLo3D+vv3H/72IT53quUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSlLZCZvSFAsLsbjMGTbFX8mEPigMVaIwB8xqGw342Q=;
 b=Cn1njuDdNfApffHvWlhNNTKMPue+mY/FjulujnN4Ccy1mo3+oBYyFwVYEaGzhuvkwr36e67gjaYZ3oOfwkdbRMUkkDAPtbyGQnnLL1Ym3jiazoUhLb43XlxUNW6Qy0jhs8N3WiB0oiF7xItpz3gEoq1YB84Tw6Ui6k/Vw1bCoG2hn9d4xCM4mPNh97FFdVh96p5+ZsM6T+JtW8RLyUMFkzhOEDSkqLLRPEC94CYogviH4khIMotSBIaLEzx1HmeYZxDPfA6JOR4+rM7y9rTX0jgZX/IMiIBVmXqhfPPkuR3kHBaa9EkdejEGti67pUKyrjOnVWAMaIYIz6FHsh5+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSlLZCZvSFAsLsbjMGTbFX8mEPigMVaIwB8xqGw342Q=;
 b=C8XAZ/FhhVP6WSrG3ZwF5kOdeOQQifV9Z74bAZ3olraGk71glROCpGXdMdhwzsOSBhtUS0CsBq3/kz0GfMdSUDVxtFfqUm30918zPr/g6teJgQ+miFz7+bir51AC10jPRG38MfIuE4UqfyYfNelpEhYp1uNhZvV6cR53ZfeTusc=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH8PR10MB6573.namprd10.prod.outlook.com (2603:10b6:510:227::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.6; Sat, 21 Jan
 2023 19:50:50 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%8]) with mapi id 15.20.6043.009; Sat, 21 Jan 2023
 19:50:50 +0000
Message-ID: <4577f120-9191-c138-299f-eeddc3652e8b@oracle.com>
Date:   Sat, 21 Jan 2023 11:50:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, aglo@umich.edu
References: <20230117193831.75201-1-jlayton@kernel.org>
 <20230117193831.75201-3-jlayton@kernel.org>
 <9bff17d4-c305-1918-5079-d2e9cf291bc7@oracle.com>
 <eb5a9fa65a8c2bcc257101c96f7fbbe18a3b74ff.camel@kernel.org>
 <3ff5458c-88ab-18ab-ebfe-98ba8050fd84@oracle.com>
 <3a910faf64ab6442fd089f17a0f7834dbf24cd41.camel@kernel.org>
 <68e2bff9-bf02-4b19-3707-be88b77d8072@oracle.com>
In-Reply-To: <68e2bff9-bf02-4b19-3707-be88b77d8072@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:806:28::26) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH8PR10MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: ce42eba2-0be7-430e-a395-08dafbe8cc3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uY9bKq+sx1xuqImq7GoWVV35AzgQO8wdQle7lbrq3vMGpanXn79GqcV08AryqtDZvoSKikGZETmqmnU6CWZJiifSzPVX+XjZaQl4bNVClttouzS6rMBVR03QYRoHl7nykwBlz8MfKJ9TAEaEnirI7kVp951pf/tlj/KZAxZrWHlsLSwQ8r+QU87QVdAGdzSdiEerAJW1pwiQ4QWUK8/7uGJH4oQP3+zDTgtf8Z4zAZWGzE4I/g1zR6PMsSk1tOcO58THxASiSE5gUxQmBfqYeDThfJ7DhVQ3yk+dpBhduHqjoP+ZZGy91DAN67tHRypUd0ppciQHWU9XPPkc0lmK7Ffb+aZUBy/OkbwcXvgWbZR7Vy1DPx5wre6qUwVP9zNGEGIsGtL9XK1JMoXGCiE4TZgWa0PZCY/mdJUFJkzxgLpRloXfYSqKT//AGYi5KQcgb5n4vRmeSDBuH30NLJF8aBAGsWI1t3zQJwvZJir+UOIicbgX5VEYsaIhJ+ad7QjEGZHxJ+PxR7gCHxjzrRZpXXWYxsGVLJXq9HYXAGb/qtAH7oBEdWfc4Ns8YZ4Qcl12NqUEOQ2peS7qegdYlP19pEC4lyDGJxWSsf2jOV1Huit3r3VNtZjEJckQ7WMDA4WrgfTB1IGaPdfNPCdXwY2odhRvAaOoQWlldlGWHFJT8Vj71MmsfElvuhUQLfeFZ1bv6QY7SwqWeMfFTRcPfbOiZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(9686003)(6512007)(186003)(83380400001)(6486002)(478600001)(316002)(2906002)(66556008)(5660300002)(2616005)(53546011)(41300700001)(36756003)(6506007)(66476007)(66946007)(86362001)(8676002)(38100700002)(26005)(6666004)(4326008)(31686004)(8936002)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXNsekg4Q0FzYmYwY09XKzdSWnY3Zyt3bTJBRlZObFp1QVRhNDB3SGgvM0ha?=
 =?utf-8?B?ZEdzTXpnek8xb1kyR0xPbVRXdU9FRWROK0dyK3hUT3czMjVxMEtLY2Z3d2w2?=
 =?utf-8?B?R1lPeXVoZitNZVphSVBwMitzd1V6cUYzRkFSSHJqZlBtQzVxc2ZiNWR1cDVU?=
 =?utf-8?B?V0YzSEgraWc4SlpRc09PelQxVGdFcDRvcUQ0VTBVckRTNGdTcFpQL0ZZZDla?=
 =?utf-8?B?LzhRd2I1WWhvSGhFclBRbjBvTHhPU1kwYkNDSzNMWmljSmVRN0tPZU9UWlRJ?=
 =?utf-8?B?UGlZTFRGajg3bzROd3VCZ0QzN3BiU0liQ1pMUU5ybXJGWnMrM2IzN2JJeHl5?=
 =?utf-8?B?MFZHYWFEZlBRb3AwbjNPZ3N3UTd6bDNTeHQwQjZ3SCt6ZVVVSXVqcFBtSURu?=
 =?utf-8?B?Sm5oQTZ0SU1NMVFTN204cDdmWW5QTGNhMVJIOVYwR1M3MFQzVk5odXJpckRJ?=
 =?utf-8?B?S2pLdGVTU0tUTlY2TFFPVmFJYzhhMStJOUhEZDJTOGFvQ3B3QzNTdkQ4cmdu?=
 =?utf-8?B?R1NpN203eHM4by8zSHcwK0xwcFUyNW1Ua0t5K25qc1NLNzdDbEhBL1FoNHgv?=
 =?utf-8?B?RlpoUFk0N05BeXBJV1g1ZDIxVTMxN3FSajRBZWpGZXFXNnBwSVNYQWVzWUgv?=
 =?utf-8?B?KzJudHN6Q2F6MWUwa0l1VXlOcGJxdGpicVdmd0lYb2VWZWdxMWpCM1ZnTDRu?=
 =?utf-8?B?VktURXh5cnc0UW02aHY5WVZaSzFJN3pSWktockpJZ3Ria3BDc3pqT0J4WmJS?=
 =?utf-8?B?YnRlZU9PelBDS2NYeXgzQ2UrWEZpUXMwMEg0K0lrOER5K1NKbC84R0FReDhE?=
 =?utf-8?B?cWgxZVNEU3BZZHVBTmdTMlpnMkk3eEY0bDk5MXUvalpSNHdJZjNUeEw2NHhp?=
 =?utf-8?B?d2ViQ0w1VVUwYlJ0NjQ3KzhKYWdMaWZMOENSc0ZVa0FsM3pkZDI2c2pLUXlN?=
 =?utf-8?B?U1ppOHZVRlkrZFJaR1BhRGJCc2QrR0w3RnZObVlQSGV1d3UvNDg3V3llUC85?=
 =?utf-8?B?anRSb2dTczg0YUJqYlM5YmZud0R5RWZXQVJHbkQ5MGpPNkZ5ZzVYTWVzT3N6?=
 =?utf-8?B?QlB1ckxpTjAvcDhmYW03UTdTQ2NsaGlvSzN6VUludE8vVXl4Y0V4WnhKNjJ6?=
 =?utf-8?B?Y1FwTTRDUDRuSkZ0SHBxLzlFREEzZ1ZxeXdUeGllT09aNm5vQjV5ZDRzNHo0?=
 =?utf-8?B?SHhGYjZRTmJjMDVtbGlZNkljM0dUSG1TSjlOTGMyVXRnOVhxZ0lKV3FYU3RZ?=
 =?utf-8?B?ZmZhM3ArM3RvcVhoaXNscm0wZjlWaUZ1MUNsOVRhWjVCVjlHVFN5UVIwd043?=
 =?utf-8?B?bjUvM2hMUk0vNWpSUzJrUUhPK1RkMUI0LzNrWGpGeGkwRi9LeHZYWWxzTUwr?=
 =?utf-8?B?TW4rU1BrUW1SaHNlRFJHMWVHK1FHWmpib2Z6S1J3VDJobWJXUWpNTG8xdmxZ?=
 =?utf-8?B?ellSUVIvSGg3NVkyNVhHS2s4VUxmZFFDSFFUUXZkQWV0L1BPbDFXVUhSaDdL?=
 =?utf-8?B?R3hkK3RXM2R3MG1DVk9yYzM0aGNKNWJ0OURUNmZkSHlqY3puVHJseVR4ZURy?=
 =?utf-8?B?WGJvcW5wWWhFai85SkVmdExzeUJQNnUxR2Jlb00yV3UrdTFZWnBtSzZDMkdF?=
 =?utf-8?B?TlpKVmhSOUxNbnBmMXNtSVNkUFlPMXF4T3l3VDJnS0RtWFZoanJSTndKVytn?=
 =?utf-8?B?Rnhqako0ajBmN1dzbTJjdFNzb3hQWG5URVVTQ2wyYU5DTHc1ZENHWUQ2OEdN?=
 =?utf-8?B?eE9LeWdvLzRmNlJ2NVVhM2JWRlVPOFltZW9jTDY1N25ZMHdHQ2trR1hZNzJl?=
 =?utf-8?B?b3JDdytuVDVIdzB4RnRVK292WTVJYVFMV2syTmtIK3pNRk5OZjExaFlKSStn?=
 =?utf-8?B?MG5wQi83SklNZWZFcmhXeXlQUWR1Nm5neGVINWI4RzFCSGhuYkJwZExscEgy?=
 =?utf-8?B?OXFjSzZkUFRwaVNTQlNVbUgyQ3NZYWhKU0lWTHBvTVZVZjVOWFhUNjM5U0Nk?=
 =?utf-8?B?cy9BdnNPVWlwOWlRS2lFRVN5VTJNelliTHVNbGxzbitKWE1FdHlVWkhBeDJm?=
 =?utf-8?B?THA4UmtxcmJ2U3B1eFNuK0xhU1BrbEFxSXNod0NtLy9yNVBtUmNmOGFObEpt?=
 =?utf-8?Q?C2eInarGWRPw7yWQk4IpNZC7h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0dZf43938FU5PuRP723H7N1WYlDKA7989iOym4kX3mS/z03AfHF/6JiCxqAL8Y+rt3lxv5ReRrjXhkgnJiIylOS8VBRCpAkhmPxfGprXviFF3+IlA/S8i1MN6ETi0HAbUH6C+6e46j5eQKDDyKkGAB5riPsi8JQaotP8lKsOBx+DpXppw7WivJMGwYsP/hX7mrI0gJFZYhso1iVCFVIURxN0J9Uh7ulRaETWw2QzDOy1Ng/si6tgKtcwSPCylT/UJ85oXpVJaY6f6eDOR9+SLjqtY4qVJgVuJMNFF1DQv8XgZAZOHJhx+xP+ZZBURZvQsA2In7nBG3pKgjVQI+9f+U/8MmjNDZR+PVLPqOLe21UMriY+BTyyo/l11lTDhLwAWzPzkCirCsPc9peSpGEaPKdnZGnYmjmasnLWsenTXuiDvQLDySWVpqZ5Lsc1vFCChNWPHca7adK9SQk3CKbUED/uJbOx/SBXO5Kfc9cytg3dHUSEHCK30XqZ9ynQfoUGjvsLCqZD+7+mwS9/9giRXMfLCXSxETsGVRZPvYiY26JM+pl3siBlADtEGlc9CIcfETfv0+CofQ6HImaD32C0tPfJXn3kmj+U2szHKw+U8KK8ae94c9C9WIcBEJzxxigU4TXeE5IpHo2ziitW69+lg210IhlAu2aw8KTymbE470VtIolOJzsOmgvFNyhgk8Vcf3N9P8S1qD448O0WZRD+OJF5yO5VIV0sGALGUcYHdz/z8qsFduihrmeI6URe8KXwrfBe0KadVJ0oLfZY7r/t9s3MmT1I9qHRHb8LCM3H/2PAo7Kp2KEh2t2gfF0tNAkm
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce42eba2-0be7-430e-a395-08dafbe8cc3a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 19:50:50.5288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zNg8l+T7DXPjqJ5IMp/7eqQwQWUl8VUMlW3xkJcrmjT35hmxUsDIOOqJeR66tec5nzwnjB//KJ8maneNHgnyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-21_13,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301210192
X-Proofpoint-GUID: 3Sy3at6ladrEdBLZAIObT36VxwUA3nab
X-Proofpoint-ORIG-GUID: 3Sy3at6ladrEdBLZAIObT36VxwUA3nab
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/21/23 10:56 AM, dai.ngo@oracle.com wrote:
>
> On 1/20/23 3:43 AM, Jeff Layton wrote:
>> On Thu, 2023-01-19 at 10:38 -0800, dai.ngo@oracle.com wrote:
>>> On 1/19/23 2:56 AM, Jeff Layton wrote:
>>>> On Wed, 2023-01-18 at 21:05 -0800, dai.ngo@oracle.com wrote:
>>>>> On 1/17/23 11:38 AM, Jeff Layton wrote:
>>>>>> There are two different flavors of the nfsd4_copy struct. One is
>>>>>> embedded in the compound and is used directly in synchronous 
>>>>>> copies. The
>>>>>> other is dynamically allocated, refcounted and tracked in the client
>>>>>> struture. For the embedded one, the cleanup just involves 
>>>>>> releasing any
>>>>>> nfsd_files held on its behalf. For the async one, the cleanup is 
>>>>>> a bit
>>>>>> more involved, and we need to dequeue it from lists, unhash it, etc.
>>>>>>
>>>>>> There is at least one potential refcount leak in this code now. 
>>>>>> If the
>>>>>> kthread_create call fails, then both the src and dst nfsd_files 
>>>>>> in the
>>>>>> original nfsd4_copy object are leaked.
>>>>>>
>>>>>> The cleanup in this codepath is also sort of weird. In the async 
>>>>>> copy
>>>>>> case, we'll have up to four nfsd_file references (src and dst for 
>>>>>> both
>>>>>> flavors of copy structure). They are both put at the end of
>>>>>> nfsd4_do_async_copy, even though the ones held on behalf of the 
>>>>>> embedded
>>>>>> one outlive that structure.
>>>>>>
>>>>>> Change it so that we always clean up the nfsd_file refs held by the
>>>>>> embedded copy structure before nfsd4_copy returns. Rework
>>>>>> cleanup_async_copy to handle both inter and intra copies. Eliminate
>>>>>> nfsd4_cleanup_intra_ssc since it now becomes a no-op.
>>>>>>
>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>> ---
>>>>>>     fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
>>>>>>     1 file changed, 10 insertions(+), 13 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>> index 37a9cc8ae7ae..62b9d6c1b18b 100644
>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>> @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct 
>>>>>> nfsd4_ssc_umount_item *nsui, struct file *filp,
>>>>>>         long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>>>>>>             nfs42_ssc_close(filp);
>>>>>> -    nfsd_file_put(dst);
>>>>> I think we still need this, in addition to release_copy_files called
>>>>> from cleanup_async_copy. For async inter-copy, there are 2 reference
>>>>> count added to the destination file, one from nfsd4_setup_inter_ssc
>>>>> and the other one from dup_copy_fields. The above nfsd_file_put is 
>>>>> for
>>>>> the count added by dup_copy_fields.
>>>>>
>>>> With this patch, the references held by the original copy structure 
>>>> are
>>>> put by the call to release_copy_files at the end of nfsd4_copy. That
>>>> means that the kthread task is only responsible for putting the
>>>> references held by the (kmalloc'ed) async_copy structure. So, I think
>>>> this gets the nfsd_file refcounting right.
>>> Yes, I see. One refcount is decremented by release_copy_files at end
>>> of nfsd4_copy and another is decremented by release_copy_files in
>>> cleanup_async_copy.
>>>
>>>>
>>>>>>         fput(filp);
>>>>>>             spin_lock(&nn->nfsd_ssc_lock);
>>>>>> @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst *rqstp,
>>>>>>                      &copy->nf_dst);
>>>>>>     }
>>>>>>     -static void
>>>>>> -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_file 
>>>>>> *dst)
>>>>>> -{
>>>>>> -    nfsd_file_put(src);
>>>>>> -    nfsd_file_put(dst);
>>>>>> -}
>>>>>> -
>>>>>>     static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
>>>>>>     {
>>>>>>         struct nfsd4_cb_offload *cbo =
>>>>>> @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct 
>>>>>> nfsd4_copy *src, struct nfsd4_copy *dst)
>>>>>>         dst->ss_nsui = src->ss_nsui;
>>>>>>     }
>>>>>>     +static void release_copy_files(struct nfsd4_copy *copy)
>>>>>> +{
>>>>>> +    if (copy->nf_src)
>>>>>> +        nfsd_file_put(copy->nf_src);
>>>>>> +    if (copy->nf_dst)
>>>>>> +        nfsd_file_put(copy->nf_dst);
>>>>>> +}
>>>>>> +
>>>>>>     static void cleanup_async_copy(struct nfsd4_copy *copy)
>>>>>>     {
>>>>>>         nfs4_free_copy_state(copy);
>>>>>> -    nfsd_file_put(copy->nf_dst);
>>>>>> -    if (!nfsd4_ssc_is_inter(copy))
>>>>>> -        nfsd_file_put(copy->nf_src);
>>>>>> +    release_copy_files(copy);
>>>>>>         spin_lock(&copy->cp_clp->async_lock);
>>>>>>         list_del(&copy->copies);
>>>>>> spin_unlock(&copy->cp_clp->async_lock);
>>>>>> @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>         } else {
>>>>>>             nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>>>>>>                            copy->nf_dst->nf_file, false);
>>>>>> -        nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>>>>>>         }
>>>>>>         do_callback:
>>>>>> @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct 
>>>>>> nfsd4_compound_state *cstate,
>>>>>>         } else {
>>>>>>             status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>>>>>>                            copy->nf_dst->nf_file, true);
>>>>>> -        nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>>>>>>         }
>>>>>>     out:
>>>>>> +    release_copy_files(copy);
>>>>>>         return status;
>>>>>>     out_err:
>>>>> This is unrelated to the reference count issue.
>>>>>
>>>>> Here if this is an inter-copy then we need to decrement the reference
>>>>> count of the nfsd4_ssc_umount_item so that the vfsmount can be 
>>>>> unmounted
>>>>> later.
>>>>>
>>>> Oh, I think I see what you mean. Maybe something like the (untested)
>>>> patch below on top of the original patch would fix that?
>>>>
>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>> index c9057462b973..7475c593553c 100644
>>>> --- a/fs/nfsd/nfs4proc.c
>>>> +++ b/fs/nfsd/nfs4proc.c
>>>> @@ -1511,8 +1511,10 @@ nfsd4_cleanup_inter_ssc(struct 
>>>> nfsd4_ssc_umount_item *nsui, struct file *filp,
>>>>           struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
>>>>           long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>>>>    -       nfs42_ssc_close(filp);
>>>> -       fput(filp);
>>>> +       if (filp) {
>>>> +               nfs42_ssc_close(filp);
>>>> +               fput(filp);
>>>> +       }
>>>>              spin_lock(&nn->nfsd_ssc_lo
>>>>           list_del(&nsui->nsui_list);
>>>> @@ -1813,8 +1815,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct 
>>>> nfsd4_compound_state *cstate,
>>>>           release_copy_files(copy);
>>>>           return status;
>>>>    out_err:
>>>> -       if (async_copy)
>>>> +       if (async_copy) {
>>>>                   cleanup_async_copy(async_copy);
>>>> +               if (nfsd4_ssc_is_inter(async_copy))
>>> We don't need to call nfsd4_cleanup_inter_ssc since the thread
>>> nfsd4_do_async_copy has not started yet so the file is not opened.
>>> We just need to do refcount_dec(&copy->ss_nsui->nsui_refcnt), unless
>>> you want to change nfsd4_cleanup_inter_ssc to detect this error
>>> condition and only decrement the reference count.
>>>
>> Oh yeah, and this would break anyway since the nsui_list head is not
>> being initialized. Dai, would you mind spinning up a patch for this
>> since you're more familiar with the cleanup here?
>
> Will do. My patch will only fix the unmount issue. Your patch does
> the clean up potential nfsd_file refcount leaks in COPY codepath.

Or do you want me to merge your patch and mine into one?

I think we need a bit more cleanup in addition to your patch. When
kmalloc(sizeof(*async_copy->cp_src), ..) or nfs4_init_copy_state
fails, the async_copy is not initialized yet so calling cleanup_async_copy
can be a problem.

-Dai

