Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B246CF229
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Mar 2023 20:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjC2Sas (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Mar 2023 14:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjC2Sar (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Mar 2023 14:30:47 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D51126
        for <linux-nfs@vger.kernel.org>; Wed, 29 Mar 2023 11:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyxTRp5T9jyaDao5PJZGXAkIsuVHQqFO35d2PW/92QsVY+4YZq+xSbW2crkNRda5TscvizIrbXkyPC3jbQd51xzxTbnkjyXKx0imA8SdVbmL4AJVn2HgiMzAnb/5hsQmxMF4xyo8mrN2UsmhFhcH+EUQYpJsVYtu4Pvy8v0JxsPbj+yOcPEew0vogfa7gkHhvkOt6RNlQwnST3SBrd6rJYpFgoZNfkAam/Bj1GsnuM+UYgnFM7P76zmp4Ze0L0lRBViAI+nPAbN1D5gXRpfvFxy3Ngx6XH+1JtViGE6B/bD7NNq/udPAe2i3EfhFncWCjSzoCPBXP6bm6Xtyd5/OeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSM3jpNQZB+juyJup/wa9sKrrkFFnGT0fALdjYpaUpU=;
 b=LP+/e9Ww95g6cBSaomtL9uhCIyMZKKol5mRYizRJHjJOKVQg/wjwlXm7UoctlGid+x0lgytuoE01P+DPHPj3lskuZcy2PShWhUNowMAMYaO+szctJGTCCL3Bkke4n6HnQwreQqSGmZMF4rjr649UWP3YZUC0/RjEfepYh1eGmW6pQ0ndgDR/mLPK2NuJ+vH3sR4MdyEx6sKLJfp2eXp8ivwB1kAG7QNiI4YvnybaITifG3OBzbo1uP3BODybM//fA0B40lAhgzPUKc+b12tE+CR9Av/iYNJopzAMoUZEQ7wub1i37hH191mSfG6SF2xCTJYxvW8nHUBc0nlFa3zliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSM3jpNQZB+juyJup/wa9sKrrkFFnGT0fALdjYpaUpU=;
 b=gbH8Ss96x0ROtFgW3nmIfOrm/TcA3JtrgrruSlx8D6hpwvcGTd/d48OyCZT7EC0EJoKzzYNaZ8OFRpnqiCdb6A4SqUjSnKTA/9a7XywZdtoxLerK8s0TdZbaavYKeBuH7wT6n3+LgEARfjSS5JcLBesZdR1/rJcvYrBIhQvNj2i4+PxCqaTXhu+ZJl1ReAoSAhWHDZ+KtkiN6JKf53Zv3Q5JuztK0ljx6WQuYT/gNXSIjtqQoRn7NOAJSb5OljEexiJgawwEDKrGvsHqYIUoriDNpGMEK5Mz/MeZ36ACAw9OhJr1ZYb+HJU/rc+D9j/A1FBmXUsQ1Onlq9oCepc/WQ==
Received: from BYAPR06MB4296.namprd06.prod.outlook.com (2603:10b6:a03:10::20)
 by BL0PR06MB4244.namprd06.prod.outlook.com (2603:10b6:208:4c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 18:30:42 +0000
Received: from BYAPR06MB4296.namprd06.prod.outlook.com
 ([fe80::c90b:a5f3:d41a:f8a3]) by BYAPR06MB4296.namprd06.prod.outlook.com
 ([fe80::c90b:a5f3:d41a:f8a3%3]) with mapi id 15.20.6178.041; Wed, 29 Mar 2023
 18:30:41 +0000
From:   "Mora, Jorge" <Jorge.Mora@netapp.com>
To:     "zhoujie2011@fujitsu.com" <zhoujie2011@fujitsu.com>,
        Jeff Layton <jlayton@kernel.org>
CC:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: nfstest_delegation test can not stop
Thread-Topic: nfstest_delegation test can not stop
Thread-Index: AQHZVhyeEgfrYxW7RUGMwOMBUm8Jra77uYeAgAAsUpWAAstQgIASSXMAgAExjCk=
Date:   Wed, 29 Mar 2023 18:30:40 +0000
Message-ID: <BYAPR06MB4296538CCA10288DC76C00B1E1899@BYAPR06MB4296.namprd06.prod.outlook.com>
References: <d5ed9eec-4bf4-8d70-0960-a30b2ef03938@fujitsu.com>
 <6ac6782b4d3efd8d76b1a590b446631a7f096752.camel@kernel.org>
 <BYAPR06MB4296C2EA5A613C7178DE2381E1BF9@BYAPR06MB4296.namprd06.prod.outlook.com>
 <d09ec9bc-a49a-81da-d746-87ba9a137833@fujitsu.com>
 <3218f65a-dcf6-32c3-5eed-32e2aa9735e5@fujitsu.com>
In-Reply-To: <3218f65a-dcf6-32c3-5eed-32e2aa9735e5@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR06MB4296:EE_|BL0PR06MB4244:EE_
x-ms-office365-filtering-correlation-id: bb0f73d5-4419-401e-981b-08db3083b34c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yshHYLlkltgmvQoZmFtXjHikRAwphpSGO1BhkYhVXfjQc80TuWG+GxSqphXs+MzB06VskophMbHCbiHsB6CNcW3rEVC8mkkepzjfpvGafyGB3rHm46/BORgM7doUEZe2bsJM6PVYXIB2LjWAUfTiegW8nx9m/poiWtM5A85+V318CUKma8u2YhuvW/4vMS9Qh6GZWzgbrWD92WL/jPTX6K309rzRFDdEXAJ6amhtEexuvlWytYHmRYWJ/2zCN0x7MqoQXIXY13hz3XeHxqGgiEmMG+ioIXzwHDKakI1aLur7hgBnDykM6orhRUz+It3CTv3KMoOATZDdVDnQAUizwGdDftjbDszoSTjl3PtN6VkYIIPM/rYkuM7YHckFSLKHrsebf1kUHVXP/y4V367ILVmboJYckrXZDPTb7nzVVJG0wqfGx8oqMe3+ggtP2YX8r4keNPuLTgKhO3qf13Sy+yBiEM4yp51Ys9EkG3ZJqIjz935XEvyx1BAr2uHTLGhB1dF06zbqCWk/C+RKC9yfQCIB+O4KM8B6+/GNF4OGlXQ8/2F7wwKVhKVpFwvJuZvs2WnJhvldmGnhEUdVcN1zAGkBc9/Nc2cyJchLihahgfSMnfy/LDIDfXMZzBghGXVz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4296.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199021)(186003)(91956017)(9686003)(7696005)(71200400001)(53546011)(6506007)(26005)(316002)(4326008)(8676002)(66946007)(64756008)(76116006)(66446008)(110136005)(66556008)(66476007)(478600001)(41300700001)(8936002)(2906002)(83380400001)(52536014)(5660300002)(122000001)(55016003)(38070700005)(86362001)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?SW9BODBYUXliVDB0aUJjZFJmRXkvTEVwWE94RzNWcWpYeDh0cWZ1dVVJ?=
 =?iso-2022-jp?B?aEcxZU5ydktmL3Z2UE1qbWJ3OFFGY3NvRXFJb1FTdWZCWTZvZzNmdk5T?=
 =?iso-2022-jp?B?UkdUQnBPQVJwWWR0WG9GN3BxZzEyMWozK1NvUDVibUtEcC9oTFliNE1o?=
 =?iso-2022-jp?B?aDV0b3ZsRUNCczc4N0l6bFRUTGlvUUxwSDZIYXFmVnQzY2oyWlJJNUpB?=
 =?iso-2022-jp?B?M3Y4ZkEyZ29xM1BkdWhPSUxJSGVKd3RvbHFIcW9EQUJXcXZBckFpWEJo?=
 =?iso-2022-jp?B?bGdiN1lEb3M2S1RTamF5dGlNTVhNZjJ5cUo1SFA0NjRNMlJvS1RRRGRQ?=
 =?iso-2022-jp?B?VURiTmM0OVhhQ2tyNGc3bFFTZmgzSGpOb3BqYWhoaDZmbnR2empBODdQ?=
 =?iso-2022-jp?B?Ulk1eXBLVGExczRBVWlWUkRPbzFhdEdYRndJRFpnNDBwWjlVbFYzSVY1?=
 =?iso-2022-jp?B?KzlYR2hreUJ6NHdqc0NXbTBKNTBnNWdJcFQrV1UrU0k5c2g4cy8rbkE3?=
 =?iso-2022-jp?B?SWlHUWVSVjZKb0s4UFFTU0xxZytPKzBRd1l4YURKU2xQYXNOY0xsS2la?=
 =?iso-2022-jp?B?dG4wbUk5a3NTdDRoRzJKSVZSMzF0bHhmYkVEaGl1eEpnSVJVRE9jVkRa?=
 =?iso-2022-jp?B?OUhoUTYrTFlpNE1WSXNEakh2WlBpWFQ4aUVjaGg2SjhpdDRLa0laemRi?=
 =?iso-2022-jp?B?Z00vME11NGlpcHdUdEdOaVl3UmxHS054TkRDUzdnSUVGa1JRdnR0eUhj?=
 =?iso-2022-jp?B?SFpJVVFPNlNrRW9Od29weGxOTTVRa3g1SUpZUzFvZm5YV0hPUXBmd2RQ?=
 =?iso-2022-jp?B?RHp6UUFtU2NRb3pOaHJiTjB0REJmZ3ZYS24weFZ6aXNwMEdReXNYL2ty?=
 =?iso-2022-jp?B?TVFDRnRXK2JSd0E1VzY4enBnRW92czltV0xPOUNrUUdiMzhyb0RUZUR0?=
 =?iso-2022-jp?B?dnNVZ0ZiV1daWnJHaGtpYlJuUFVtdFV3K0s2TFV5ZFhvNDNaRGJkbGlz?=
 =?iso-2022-jp?B?VU8vQ3ZHWHY5SFMxY2pMdXVFS25JTEdyNGphTlFyVnYzbTRCeFBZZVlm?=
 =?iso-2022-jp?B?eXhoMldqeWhaMWtyeTZ1SE1zY3RZcmxINFAwRmh6cFkySC82WGhFdFBr?=
 =?iso-2022-jp?B?dm1pdGJtNk9nTnpDZG9XVmJudVVTaWh3OCtNaEtLSS9WVUcrcFhRNC9m?=
 =?iso-2022-jp?B?SGV1UkpzYlFvdEdKUGxkc1NLbElGaWI0N1Zvd2NaeFg0VWVMeDRXdkE4?=
 =?iso-2022-jp?B?R0pqeUxMaml5cEE5alhQWkVsNFRKTzc2T3BQYlYyYlc4ZnF2Si9KOTl2?=
 =?iso-2022-jp?B?U1hRamowTGUzWkRFTkg2UDlZeXZsbXFaMWd4YjhCZ3cxUVY5SS9hWXBa?=
 =?iso-2022-jp?B?OE9lYVFqWFV3byt4TTlVTmV4WlVxRlVoUFFHK2pvelZrdVRmZERpc3hy?=
 =?iso-2022-jp?B?aUF5T0x5emZVZlBhYkZpUG5rR21rU3pRU3dXVE9rck5KSzZZWWNIYUw5?=
 =?iso-2022-jp?B?OXhRMUFrbVFEdlN0SVFPOVV4S3J1NU8wRGErS1U1amxjbGlMK2s1b2xr?=
 =?iso-2022-jp?B?NUIyRVE5ZkdOU1VETWxwWXpwUVBVOXoxYmp6dkl2WThNYTVwdmNRV20w?=
 =?iso-2022-jp?B?OUxZekQ4QUt2cXY5WDZ0NG9OeUV3b3cxVzFnd0p0QmVETER0N0lxWGhu?=
 =?iso-2022-jp?B?RGswSm9xVUxnVitBRlNBcExMU0FMcXFEY3BVdmhaRXgyVHlFSDhvMi82?=
 =?iso-2022-jp?B?VmRkd1MxQ3gzWFpwVkdIdVFsWno0SHZ1Skd2UFFUOUxEdHpBeWFnQXh1?=
 =?iso-2022-jp?B?TEQ4WFE1OXZtQkl6RkZ5a09HYzFKTDN4eWNESW05Z1ZtMnVEdjEva0tj?=
 =?iso-2022-jp?B?Q0RiaUtTS3BhZ1Z4b1NOTjhlVHZaTmNPRFdHcXBIL3ZvK2JsdW05UjlI?=
 =?iso-2022-jp?B?YkJpdVZXMjZRUnVCVjhrM0cvZXgyUk5zMEs3aVVYeHRTKzQxQStHeVhu?=
 =?iso-2022-jp?B?WmtWOUFDSVc4ek9IZUZkd1lIT2hNcXdSak53dTlJU3dMb2p6NDFJeUNO?=
 =?iso-2022-jp?B?OW1GUW8wTXlGaFBMRE40ZGlKSlRJTU5rdVNYdUFGWmlsb3RLWnMvUlFD?=
 =?iso-2022-jp?B?RVllOXczWGx2Y212bFRvNkZTWlVzR0VCVzdidkhlbHo2Qmd3VVQzY0tW?=
 =?iso-2022-jp?B?SVpiUklmdGJrUkt6amtsRlZwa2JRQklzVlk2M3lhZFljVllCZnZudElM?=
 =?iso-2022-jp?B?ZldmWjdUdWo5SThMU2l3V0FKT2pybjdWdz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB4296.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0f73d5-4419-401e-981b-08db3083b34c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 18:30:40.9578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOPcpCptYcOz3kBRybJXYyvzr6suHdGwrBwLfsGVBgami1JgPQICN7HayO/l6hrn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR06MB4244
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,=0A=
=0A=
I am still waiting for all the files created for the run, not just the outp=
ut to the screen:=0A=
=0A=
/tmp/nfstest_delegation_20230317_170647*=0A=
=0A=
=0A=
--Jorge=0A=
=0A=
________________________________________=0A=
From: zhoujie2011@fujitsu.com <zhoujie2011@fujitsu.com>=0A=
Sent: Tuesday, March 28, 2023 6:15 PM=0A=
To: Mora, Jorge; Jeff Layton=0A=
Cc: linux-nfs=0A=
Subject: Re: nfstest_delegation test can not stop=0A=
=0A=
NetApp Security WARNING: This is an external email. Do not click links or o=
pen attachments unless you recognize the sender and know the content is saf=
e.=0A=
=0A=
=0A=
=0A=
=0A=
ping=0A=
=0A=
On 3/17/23 16:58, zhoujie2011 wrote:=0A=
> hi,=0A=
>=0A=
>  > Can you provide a log file for the run?=0A=
> run following command and test result is attached.=0A=
> ./nfstest_delegation --nfsversion=3D4 -e /nfsroot --server 192.168.122.11=
0=0A=
> --client 192.168.122.109 --trcdelay 10 -v all --createlog --keeptraces=0A=
> --rexeclog recall22 >nfstest-delegationv4-log_recall22 2>&1=0A=
>=0A=
> In server run "cat /etc/exports" output is following.=0A=
> /nfsroot      *(rw,insecure,no_subtree_check,no_root_squash,fsid=3D1)=0A=
>=0A=
> best regards,=0A=
>=0A=
> On 3/15/23 22:28, Mora, Jorge wrote:=0A=
>> Hello,=0A=
>>=0A=
>> Can you provide a log file for the run?=0A=
>>=0A=
>> ./nfstest_delegation -s 192.168.68.86 -e /export -v all --createlog=0A=
>> --keeptraces --rexeclog recall22=0A=
>>=0A=
>> --Jorge=0A=
>>=0A=
>> *From: *Jeff Layton <jlayton@kernel.org>=0A=
>> *Date: *Wednesday, March 15, 2023 at 5:40 AM=0A=
>> *To: *zhoujie2011@fujitsu.com <zhoujie2011@fujitsu.com>, Mora, Jorge=0A=
>> <Jorge.Mora@netapp.com>=0A=
>> *Cc: *linux-nfs <linux-nfs@vger.kernel.org>=0A=
>> *Subject: *Re: nfstest_delegation test can not stop=0A=
>>=0A=
>> NetApp Security WARNING: This is an external email. Do not click links=
=0A=
>> or open attachments unless you recognize the sender and know the=0A=
>> content is safe.=0A=
>>=0A=
>>=0A=
>>=0A=
>>=0A=
>> On Tue, 2023-03-14 at 02:28 +0000, zhoujie2011@fujitsu.com wrote:=0A=
>>  > hi,=0A=
>>  >=0A=
>>  > I run following test command and stuck at recall12 recall14 recall20=
=0A=
>>  > recall22 recall40 recall42 recall48 recall50.=0A=
>>  >=0A=
>>  > ./nfstest_delegation --nfsversion=3D4 -e /nfsroot --server <server ip=
>=0A=
>>  > --client <client2 ip> --trcdelay 10=0A=
>>  > ./nfstest_delegation --nfsversion=3D4.1 -e /nfsroot --server  <server=
=0A=
>> ip>=0A=
>>  > --client <client2 ip> --trcdelay 10=0A=
>>  > ./nfstest_delegation --nfsversion=3D4.2 -e /nfsroot --server  <server=
=0A=
>> ip>=0A=
>>  > --client <client2 ip> --trcdelay 10=0A=
>>  >=0A=
>>  > recall12 recall14 recall20 recall22 recall40 recall42 recall48=0A=
>> recall50=0A=
>>  > tests write files after remove.=0A=
>>  > After comment out above testcases result is:=0A=
>>  > 646 tests (588 passed, 58 failed)=0A=
>>  > FAIL: WRITE delegation should be granted=0A=
>>  >=0A=
>>  > run ./nfstest_dio have following messages.=0A=
>>  > INFO: 16:19:51.455222 - WRITE delegations are not available --=0A=
>> skipping=0A=
>>  > tests expecting write delegations=0A=
>>  >=0A=
>>  > test OS: RHEL9.2 Nightly Build=0A=
>>  > Why do these testcases can not stop?=0A=
>>=0A=
>> Are you asking why these testcases don't pass? If you're testing against=
=0A=
>> the kernel's NFS server then it's because it does not (yet) support=0A=
>> write delegations.=0A=
>> --=0A=
>> Jeff Layton <jlayton@kernel.org>=0A=
>>=0A=
>=0A=
=0A=
--=0A=
------------------------------------------------=0A=
zhoujie=0A=
Dept 1=0A=
No. 6 Wenzhu Road,=0A=
Nanjing, 210012, China=0A=
TEL=1B$B!'=1B(B+86+25-86630566-8508=0A=
FUJITSU INTERNAL=1B$B!'=1B(B7998-8508=0A=
E-Mail=1B$B!'=1B(Bzhoujie2011@fujitsu.com=0A=
------------------------------------------------=0A=
